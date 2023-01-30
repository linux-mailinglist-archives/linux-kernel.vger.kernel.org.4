Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC30680AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjA3Kcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjA3Kc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:32:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6432507
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:32:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k4so24854169eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SU4TvQBEgsKKX2t0zkVWhwaH0XkZ8pAq9qTFSGxD3dQ=;
        b=OP1Z651F8+txYxyFcpg82bxGALd1Nr0m84TaBvHjkdT6RgqqxMFJRKUTe6fKCvTRfm
         Fik+PpCu+upHtu7lgXul8+iYM9yoMEeHpKBN1J6hCcKa4npYzJ+tAuv3dKPySLlHR9jM
         XokDuNuNlT12W/pP6Hxr3W69Df4tZyvDlMDJfbFom3SlMJGXTMI1azdhDF0g05hIgfIJ
         wx7HpzDmUtqWWUQ9jsIAYaZUZgbnUFekmVHjKVIPqakcP10/QuAN8bhN9IE+S71YEiw5
         GHBdcpKzt+E7WrXDZKQOuRw35tWYDMuI/8xYL2oHJm5Bom/jMuG2sU+uJgmTF905O8Zb
         BFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU4TvQBEgsKKX2t0zkVWhwaH0XkZ8pAq9qTFSGxD3dQ=;
        b=FhmZRfes1auF7DtP7NMd+8KJtSol2F6d0K3cIkRKKXnj7RPKIrSz3lFFZ0rz9ZCdWx
         waAW4G3LmVHNy9EZiFXA6iZ6Xe6Nc0vKk3wEk5MXVqBjm6aRpnWFBm5XG1N5TEd4a2R/
         /JKGVxvnMfobPy1Lg5wlqR34KX7Btg4wLtQ2Q0dqot4Gej2JTucCrcSecMndwQRzzDkb
         URUaWjYxrQjr9TvGikmeObMOZnhosArtuEfqnOWln2Ua+hkP9xY6u/9+iI5jM5mxMlyi
         8jWCRIEp8uIdVCOV8UlelWl6ONnZftgw1cjeZQ9vH8fKiexFnE6LgXvi83CMxqdnrQMF
         rwHA==
X-Gm-Message-State: AO0yUKXpsf+i1VLe19RdcA6jZh/Ih74dAQbEO3mtA1+HgN9N87ckLL80
        G4HOMZHLlXiolsddmtnm1/x8Sw9l08Y75Rz+cEg=
X-Google-Smtp-Source: AK7set8k4wfgHo0U50knfveZl6pWbGTSilVGX7dAGQjHEJTb5OY/TK8f6PYxFRnhG/6fYoTwNd8GZA==
X-Received: by 2002:a17:906:275b:b0:88a:d7dc:2dbe with SMTP id a27-20020a170906275b00b0088ad7dc2dbemr409784ejd.74.1675074744473;
        Mon, 30 Jan 2023 02:32:24 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709060f1500b0084debc3fdadsm6625756eji.188.2023.01.30.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:32:23 -0800 (PST)
Date:   Mon, 30 Jan 2023 11:32:22 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, sgoutham@marvell.com
Subject: Re: [net PATCH v1] octeontx2-af: Fix devlink unregister
Message-ID: <Y9ecthytH/d+xV5v@nanopsycho>
References: <20230130060443.763564-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130060443.763564-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 30, 2023 at 07:04:43AM CET, rkannoth@marvell.com wrote:
>Exact match devlink entry is only for CN10K-B.
>Unregistration devlink should subtract this
>entry before invoking devlink unregistration
>
>Fixes: 87e4ea29b030 ("octeontx2-af: Debugsfs support for exact match.")
>Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>---
> .../marvell/octeontx2/af/rvu_devlink.c        | 37 ++++++++++++++-----
> 1 file changed, 28 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
>index bda1a6fa2ec4..4950eb13a79f 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
>@@ -1500,6 +1500,9 @@ static const struct devlink_param rvu_af_dl_params[] = {
> 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> 			     rvu_af_dl_dwrr_mtu_get, rvu_af_dl_dwrr_mtu_set,
> 			     rvu_af_dl_dwrr_mtu_validate),
>+};
>+
>+static const struct devlink_param rvu_af_dl_param_exact_match[] = {
> 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
> 			     "npc_exact_feature_disable", DEVLINK_PARAM_TYPE_STRING,
> 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>@@ -1556,7 +1559,6 @@ int rvu_register_dl(struct rvu *rvu)
> {
> 	struct rvu_devlink *rvu_dl;
> 	struct devlink *dl;
>-	size_t size;
> 	int err;
> 
> 	dl = devlink_alloc(&rvu_devlink_ops, sizeof(struct rvu_devlink),
>@@ -1578,18 +1580,29 @@ int rvu_register_dl(struct rvu *rvu)
> 		goto err_dl_health;
> 	}
> 
>-	/* Register exact match devlink only for CN10K-B */
>-	size = ARRAY_SIZE(rvu_af_dl_params);
>-	if (!rvu_npc_exact_has_match_table(rvu))
>-		size -= 1;
>-
>-	err = devlink_params_register(dl, rvu_af_dl_params, size);
>+	err = devlink_params_register(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
> 	if (err) {
> 		dev_err(rvu->dev,
> 			"devlink params register failed with error %d", err);
> 		goto err_dl_health;
> 	}
> 
>+	/* Register exact match devlink only for CN10K-B */
>+	if (!rvu_npc_exact_has_match_table(rvu))
>+		goto done;
>+
>+	err = devlink_params_register(dl, rvu_af_dl_param_exact_match,
>+				      ARRAY_SIZE(rvu_af_dl_param_exact_match));
>+	if (!err)
>+		goto done;

Could you please follow the common error path pattern?
	if (err)
		goto err_something;

	return 0;


>+
>+	dev_err(rvu->dev,
>+		"devlink exact match params register failed with error %d", err);
>+
>+	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
>+	goto err_dl_health;
>+
>+done:
> 	devlink_register(dl);
> 	return 0;
> 
>@@ -1605,8 +1618,14 @@ void rvu_unregister_dl(struct rvu *rvu)
> 	struct devlink *dl = rvu_dl->dl;
> 
> 	devlink_unregister(dl);
>-	devlink_params_unregister(dl, rvu_af_dl_params,
>-				  ARRAY_SIZE(rvu_af_dl_params));
>+
>+	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
>+
>+	/* Unregister exact match devlink only for CN10K-B */
>+	if (rvu_npc_exact_has_match_table(rvu))
>+		devlink_params_unregister(dl, rvu_af_dl_param_exact_match,
>+					  ARRAY_SIZE(rvu_af_dl_param_exact_match));
>+
> 	rvu_health_reporters_destroy(rvu);
> 	devlink_free(dl);
> }
>-- 
>2.25.1
>
