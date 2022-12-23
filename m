Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94562655269
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiLWPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiLWPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:47:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08330F40
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:47:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38CEE68AA6; Fri, 23 Dec 2022 16:47:54 +0100 (CET)
Date:   Fri, 23 Dec 2022 16:47:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn:
 missing error code? 'ret'
Message-ID: <20221223154754.GA30339@lst.de>
References: <202212222333.vrYfUBqM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212222333.vrYfUBqM-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the code in nvme_auth_generate_key I assume this is intentional,
but the code looks really confusing.

Hannes, Sagi, what do you think of something like this:


diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7b9..a07eb4cd9ce173 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -455,28 +455,18 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
 
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
+struct nvme_dhchap_key *nvme_auth_generate_key(u8 *secret)
 {
-	struct nvme_dhchap_key *key;
 	u8 key_hash;
 
-	if (!secret) {
-		*ret_key = NULL;
-		return 0;
-	}
+	if (!secret)
+		return NULL;
 
 	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + 10, key_hash);
-	if (IS_ERR(key)) {
-		*ret_key = NULL;
-		return PTR_ERR(key);
-	}
-
-	*ret_key = key;
-	return 0;
+	return nvme_auth_extract_key(secret + 10, key_hash);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index bb0abbe4491cdc..c808652966a94f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -943,16 +943,19 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
-			&ctrl->host_key);
-	if (ret)
-		return ret;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
-			&ctrl->ctrl_key);
-	if (ret)
+
+	ctrl->host_key = nvme_auth_generate_key(ctrl->opts->dhchap_secret);
+	if (IS_ERR(ctrl->host_key)) {
+		ret = PTR_ERR(ctrl->host_key);
+		goto out;
+	}
+	ctrl->ctrl_key = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret);
+	if (IS_ERR(ctrl->ctrl_key)) {
+		ret = PTR_ERR(ctrl->ctrl_key);
 		goto err_free_dhchap_secret;
+	}
 
-	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
+	if (!ctrl->host_key && !ctrl->ctrl_key)
 		return ret;
 
 	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
@@ -972,9 +975,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	return 0;
 err_free_dhchap_ctrl_secret:
 	nvme_auth_free_key(ctrl->ctrl_key);
-	ctrl->ctrl_key = NULL;
 err_free_dhchap_secret:
+	ctrl->ctrl_key = NULL;
 	nvme_auth_free_key(ctrl->host_key);
+out:
 	ctrl->host_key = NULL;
 	return ret;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f72fc3bd07c348..6245f1c87c5ba8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3751,11 +3751,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
 		struct nvme_dhchap_key *key, *host_key;
-		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
+		key = nvme_auth_generate_key(dhchap_secret);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -3805,11 +3804,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
 		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
+		key = nvme_auth_generate_key(dhchap_secret);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062ddaf..df82d7950ee204 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -28,7 +28,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
+struct nvme_dhchap_key *nvme_auth_generate_key(u8 *secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 				  u8 *challenge, u8 *aug, size_t hlen);
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);

