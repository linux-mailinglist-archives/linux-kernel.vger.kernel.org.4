Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7EC644026
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiLFJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiLFJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:48:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BE1FFB9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:47:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c66so13187513edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoyIxqzGZXgkn5M48vTsEEz1oFW22vZOFSRNqKRONdI=;
        b=LYxydK/vo4udT1IuesDJ4X1pr5TXVAqVsN56s2RHt8ScC+nglGHQTnF/jrLDOXMQmC
         Aqi4ks6uTxA2PNILZLOJLyFBlj67dp29gh+UeaZkvZZKE2Eej2RNp5U+JI3n5npc0BNg
         +EkJFDdlnb53VPKolMU8QhR9VXfkrubjE7uBx5R2bt0w0JmZIyqNmViD9++exuXmfJ54
         As+pPh1QiKznYtDFHmKxi6lBe9R3WDMXRUnLNX6J/2n6emq0gXyJ/s14SEU9/s/YKRsz
         UiJzQt2PuMUwETPTSlg8oGWxOmow5PjNTg0muMfCYUusWE2wBiKdWB4UB2JImMCoOmjJ
         pHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoyIxqzGZXgkn5M48vTsEEz1oFW22vZOFSRNqKRONdI=;
        b=xRgDdqzYmwNjlwiDllzQEYOCCjbm8ad2uFIUFxXLL22ZnEd/5w7ASXtCYDdS0pqRtl
         pEkr7o92M+WgnJHjFO6kXPRSeIW+NHYO6zzeq1jPvWlmMTFkP1h0Tp2NNdYeWviLAHxf
         AAPbpRCzOQRm+H7p3qTcSLRmsaQBVQIn1mrykWuE7+xcMzrRh0Hck6otnKo4wWg2RYvD
         3VGtPiqQvCyMAbPnp8DcDI3fMAymIdDs81D8rTGJHPcWLpOsM50MxMazS4/+CqvaC0qW
         YT64ILfhrNUwwjM3btM5hcEPoRP3onHcKdIra7DuZr/q+vs0CMGtFt0FFA4OsQlILdgC
         Z7Tw==
X-Gm-Message-State: ANoB5pk0fqNoH50tdB4hxTYPuIdgQy2ecXGBRlyoWjrCM67Lvwudc0v0
        VFDdb6FEyLN0seNyISxwiF9xlg==
X-Google-Smtp-Source: AA0mqf7n2tInC77VKPPE3/C2Gq+yrWHnbdfb/lyUBEa+63aDRK8dnp4+W16hlQQwo4Tt9DLnuR2T3A==
X-Received: by 2002:aa7:c9cd:0:b0:461:891a:8162 with SMTP id i13-20020aa7c9cd000000b00461891a8162mr75384182edt.398.1670320023337;
        Tue, 06 Dec 2022 01:47:03 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170907819100b007c03fa39c33sm7108996ejc.71.2022.12.06.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:47:02 -0800 (PST)
Date:   Tue, 6 Dec 2022 10:47:01 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Add check for kzalloc
Message-ID: <Y48PlUNsVKlvpRTd@nanopsycho>
References: <20221206030805.15934-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206030805.15934-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Dec 06, 2022 at 04:08:05AM CET, jiasheng@iscas.ac.cn wrote:
>As kzalloc may fail and return NULL pointer,
>it should be better to check the return value
>in order to avoid the NULL pointer dereference.

Okay, so? Be imperative to the code base, tell it what to do in your
patch description.


>
>Fixes: d6b98c8d242a ("ice: add write functionality for GNSS TTY")
>Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>---
> drivers/net/ethernet/intel/ice/ice_gnss.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
>index b5a7f246d230..6d3d5e75726b 100644
>--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
>+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
>@@ -421,7 +421,7 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
> 	const int ICE_TTYDRV_NAME_MAX = 14;
> 	struct tty_driver *tty_driver;
> 	char *ttydrv_name;
>-	unsigned int i;
>+	unsigned int i, j;
> 	int err;
> 
> 	tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
>@@ -462,6 +462,17 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
> 					       GFP_KERNEL);
> 		pf->gnss_serial[i] = NULL;
> 
>+		if (!pf->gnss_tty_port[i]) {
>+			for (j = 0; j < i; j++) {
>+				tty_port_destroy(pf->gnss_tty_port[j]);

You are destroying port which you didn't call (pf->gnss_tty_port[i])
for. Also, you are introducing a code duplication here with the error
path couple of lines below. Please convert this to goto-label error
path so the cleanup code is shared.


>+				kfree(pf->gnss_tty_port[j]);
>+			}
>+			kfree(ttydrv_name);
>+			tty_driver_kref_put(pf->ice_gnss_tty_driver);
>+
>+			return NULL;
>+		}
>+
> 		tty_port_init(pf->gnss_tty_port[i]);
> 		tty_port_link_device(pf->gnss_tty_port[i], tty_driver, i);
> 	}
>-- 
>2.25.1
>
