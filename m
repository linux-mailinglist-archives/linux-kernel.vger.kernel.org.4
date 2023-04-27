Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF46F02C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243147AbjD0Ipq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjD0Ipn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:45:43 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625844C01
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:45:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230427084537epoutp03b1c9bba046feb419a77a7dc36562542b~ZvkR_zexf2679426794epoutp03D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:45:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230427084537epoutp03b1c9bba046feb419a77a7dc36562542b~ZvkR_zexf2679426794epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682585137;
        bh=PlMURogrOakEItrZ/CspC/ieLWi0smmp1t6x9YbaHkA=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=NZfKUqJIZdcalc/kRAHUvQJ/EDPvTZAYIEonaoFwEKknl+KvBoxjkGNsDkMXCy9xB
         m2JcYRArFHUm9UTK3AdeXarJ9siQrxOnVHYTc9D0Ybrz5XNOwuY/KdVmi26dUI3ssG
         cAIuIKtAXg/gXqvWxl9uPLNyRtKkAitDj+wMMF/k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230427084536epcas2p2c2dce5f073875e2e41de267ae6277435~ZvkRfjjfW0972609726epcas2p2c;
        Thu, 27 Apr 2023 08:45:36 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q6TpR6F8Bz4x9Pp; Thu, 27 Apr
        2023 08:45:35 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-0c-644a362f3a21
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.D3.17293.F263A446; Thu, 27 Apr 2023 17:45:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Keoseong Park <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ceaaf07b-d684-e88d-cfda-257cef32305a@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230427084535epcms2p20fc85abb7cf2efd77866b94ecb718047@epcms2p2>
Date:   Thu, 27 Apr 2023 17:45:35 +0900
X-CMS-MailID: 20230427084535epcms2p20fc85abb7cf2efd77866b94ecb718047
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmqa6+mVeKwZobOhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjT4tHtZ4wWi25sY7I4fvIdo8XlXXPYLLqv72CzWH78H5PFwo65LBZL
        t95kdOD1uHzF22PCogOMHi0n97N4fF/fwebx8ektFo+Je+o8+rasYvT4vEnOo/1AN1MAZ1S2
        TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q1UoKZYk5
        pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwF
        M1pZCk6IVEy8e5m1gfGxQBcjJ4eEgInEkrs3WLoYuTiEBHYwSszd+o69i5GDg1dAUOLvDmGQ
        GmEBN4lPD26ygthCAkoSXQu3MkPEDSTWTd8DZrMJ6ElM+X2HEWSOiMBGFomNv84xQizglZjR
        /pQFwpaW2L58K1icU8BaYuuCf1A1GhI/lvUyQ9iiEjdXv2WHsd8fmw9VIyLReu8sVI2gxIOf
        u6HikhKtZ7ayQdj1Eq3vT7GDHCEhMIFRovHYH6hB+hLXOjaCHcEr4CvR8n0dWDOLgKrEpQfT
        wB6WEHCR2HikGCTMLCAvsf3tHGaQMLOApsT6XfoQFcoSR26xQFTwSXQc/ssO82HDxt9Y2Tvm
        PWGCsNUkHi3Ywgphy0hcnHOOeQKj0ixEQM9CsncWwt4FjMyrGMVSC4pz01OLjQqM4HGbnJ+7
        iRGcfrXcdjBOeftB7xAjEwfjIUYJDmYlEV7eSvcUId6UxMqq1KL8+KLSnNTiQ4ymQA9PZJYS
        Tc4HZoC8knhDE0sDEzMzQ3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9TBycUg1MDELJO8O2
        Zj5jLb1jppi4Vuyc8V7bO0fOrtQ17Y94rbL+9owGYFRd+f4l4dWjcINDF5fM28F1/pDEt+Ob
        8ktc32rnOwZP3NVVbHlVJuyjnuesDTJ/0gL27p4tFr5zyrF0V55ixidulSUtXyWSSp+vX1Mc
        cUZ/iuE2lQk7GJ5XNU9T+KmZY8TYdG2bh1oiY1YJi+PdheuP332sFae84+AMjgOHbu+Lidxv
        8aP/U20rx+fXdikzlQVFLstl2P7ouH/G6s5TNw1b3/v63alM3q+/nOFdN9O4eFK4dD2jbNom
        IRUuL6vdydcsdH4wGoR9WdzkFLbCWnL/pnX3ncITc8I3fYquWGP/2Xzrsc38KquUWIozEg21
        mIuKEwGlF6GpSAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230426052153epcms2p27d64a865f15bfd452d564f77d63605db
References: <ceaaf07b-d684-e88d-cfda-257cef32305a@acm.org>
        <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
        <CGME20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,
Thank you for your review.

>On 4/25/23 22:21, Keoseong Park wrote:
>> This function does not require the "ret" variable because it returns
>> only the result of param_set_bool().
>> 
>> Remove unnecessary "ret" variable and simplify the code.
>> 
>> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>> 
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 9434328ba323..46c4ed478ad0 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -108,13 +108,7 @@ static bool is_mcq_supported(struct ufs_hba *hba)
>>   
>>   static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
>>   {
>> -	int ret;
>> -
>> -	ret = param_set_bool(val, kp);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return 0;
>> +	return param_set_bool(val, kp);
>>   }
>>   
>>   static const struct kernel_param_ops mcq_mode_ops = {
>
>Why do we even have the param_set_mcq_mode() callback? Has it been considered
>to remove mcq_mode_ops as in the untested patch below?

I agree with you in that it only uses param_{set,get}_bool().
So, I'll test the patch below and send it.

Best Regards,
Keoseong

>
>Thanks,
>
>Bart.
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index 7b1e7d7091ff..2b8c2613f7d7 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -98,7 +98,7 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>
>-/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
>+/* UFSHC 4.0 compliant HC support this mode. */
>  static bool use_mcq_mode = true;
>
>  static bool is_mcq_supported(struct ufs_hba *hba)
>@@ -106,23 +106,7 @@ static bool is_mcq_supported(struct ufs_hba *hba)
>  	return hba->mcq_sup && use_mcq_mode;
>  }
>
>-static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
>-{
>-	int ret;
>-
>-	ret = param_set_bool(val, kp);
>-	if (ret)
>-		return ret;
>-
>-	return 0;
>-}
>-
>-static const struct kernel_param_ops mcq_mode_ops = {
>-	.set = param_set_mcq_mode,
>-	.get = param_get_bool,
>-};
>-
>-module_param_cb(use_mcq_mode, &mcq_mode_ops, &use_mcq_mode, 0644);
>+module_param(use_mcq_mode, bool, 0644);
>  MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from UFSHCI 4.0. 1 - enable MCQ, 0 - disable MCQ. MCQ is enabled by default");
>
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
