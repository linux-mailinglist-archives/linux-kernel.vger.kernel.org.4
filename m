Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC26EF89A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDZQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDZQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:44:39 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE722727;
        Wed, 26 Apr 2023 09:44:38 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-246f856d751so5170838a91.0;
        Wed, 26 Apr 2023 09:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682527477; x=1685119477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiIQGs9lDJpO3uMuMZoURiKGm77nW3DUPJPQrXJs0uE=;
        b=JvrDF0PeUeEQJSy+xkhTY9ExgPmzgvRQHjNzAFk5MN7LjIqH7CIYZtykBsZa8gEkjR
         l2yty5JFlbtpFgaMqRHWnniwa9JYyqAuA4HEwPWaaz8PboNzCqPsLedHul31HhgIdfoP
         x96z7aEVZsgEFRfmIMYbTv8/H/jCUY6fpE9hu/2cEligjc+qRs5erUETZM0usNp5I2o9
         C6aO3XJyYQFymVxuBQ3NBUBgLR+0EMOesgOXPfK2RLPWRPdnx/0H6PMBufuiJK0qR3wn
         YYs2qqvRgMS5n5zuUIAuBvCw+W0oxtK0bizD81thmE1V2ia5aHhbEVUnR4guSh2Ma8iA
         5rnw==
X-Gm-Message-State: AAQBX9dWYXVCLccOm3IuIf/94mqswyo0tf7eFOC1kJ0x4wVQ2il5xIBT
        w8pCARDpi8AsTZw9lL2uyIo=
X-Google-Smtp-Source: AKy350bezpvgAWRLrM2q/DENDgYO0DYazMzv1x9T95SCFX76a5Z9wHp1cxtzqH6l/ORWyiTP6b/47g==
X-Received: by 2002:a17:90a:4812:b0:23b:4439:4179 with SMTP id a18-20020a17090a481200b0023b44394179mr21143122pjh.28.1682527477185;
        Wed, 26 Apr 2023 09:44:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5099:ad7c:6c1:9570? ([2620:15c:211:201:5099:ad7c:6c1:9570])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adb0200b00246f9725ffcsm9858549pjv.33.2023.04.26.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 09:44:36 -0700 (PDT)
Message-ID: <ceaaf07b-d684-e88d-cfda-257cef32305a@acm.org>
Date:   Wed, 26 Apr 2023 09:44:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
 <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
Content-Language: en-US
In-Reply-To: <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 22:21, Keoseong Park wrote:
> This function does not require the "ret" variable because it returns
> only the result of param_set_bool().
> 
> Remove unnecessary "ret" variable and simplify the code.
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 9434328ba323..46c4ed478ad0 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -108,13 +108,7 @@ static bool is_mcq_supported(struct ufs_hba *hba)
>   
>   static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
>   {
> -	int ret;
> -
> -	ret = param_set_bool(val, kp);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return param_set_bool(val, kp);
>   }
>   
>   static const struct kernel_param_ops mcq_mode_ops = {

Why do we even have the param_set_mcq_mode() callback? Has it been considered
to remove mcq_mode_ops as in the untested patch below?

Thanks,

Bart.

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7b1e7d7091ff..2b8c2613f7d7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -98,7 +98,7 @@
  /* Polling time to wait for fDeviceInit */
  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */

-/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
+/* UFSHC 4.0 compliant HC support this mode. */
  static bool use_mcq_mode = true;

  static bool is_mcq_supported(struct ufs_hba *hba)
@@ -106,23 +106,7 @@ static bool is_mcq_supported(struct ufs_hba *hba)
  	return hba->mcq_sup && use_mcq_mode;
  }

-static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
-{
-	int ret;
-
-	ret = param_set_bool(val, kp);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static const struct kernel_param_ops mcq_mode_ops = {
-	.set = param_set_mcq_mode,
-	.get = param_get_bool,
-};
-
-module_param_cb(use_mcq_mode, &mcq_mode_ops, &use_mcq_mode, 0644);
+module_param(use_mcq_mode, bool, 0644);
  MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from UFSHCI 4.0. 1 - enable MCQ, 0 - disable MCQ. MCQ is enabled by default");

  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
