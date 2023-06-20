Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32B736515
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjFTHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFTHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:45:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390A1B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:45:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so52591421fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687247103; x=1689839103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wESTR9hp8QbMJwR1Q1phtcrcKn8kK2hZnv+6lF1RSbE=;
        b=UbRFJO/7SOyqKIZckxXwxHNU4Nmlb0G43+TakTCeqG2mdXo/VjE97pNrhhDKGuqul6
         g0FDSgQ1qhlFRm66v2CSR07HEumgOiI1DwY70cvZ/GRnH3GfRPO/rQXbF1Svml7efMkh
         lhp9MswnOIHmtxPe6YalCOL2HsaeUEJ1reXvdnquy86Yz3ekmbH8PJNZHnxHquD3AOqx
         EgxWf74zYgBhQ2Sxh9FNRWpZuodQDfPg+3tl0Z1GfgQyuZfTgssS7hr9akr9b+chCghg
         +BSx/W2fCD9px1aN4YbOwgziz4ZOrjlN0uhBjcARDLHWbletHPL7ZmyaQfGhp33/A1K5
         qigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247103; x=1689839103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wESTR9hp8QbMJwR1Q1phtcrcKn8kK2hZnv+6lF1RSbE=;
        b=NvIrIiCyWXX5lLTnSQ7UfUbs8Rzl3r6EdL9DCcjN1M3Qsqdstu4seP5yu6GBG01Xxe
         v23u9uKt02P/0xiSiHJirgrB5bV/84Q1cmrezX5RrHgQLlDQ8PpvP0OWRexJ6FHMaKri
         2xdUmUqG5Q5iGGmHMxASN3vF3y1AWbyJTZBIIpNR7xhboidwq07XERa+9MibyROrMVdu
         GFYM+g7zdd44RpTqMKnTiA3Ap1RNFAKGqhTqp6Ce5+x+Z+b9AhB4eHgJS20Ceg7L7LnZ
         sYXGHiC0DIQpc6q+viCVq4fboDDsN90aHuhBynYP2hwPY1yqVkCNWRqYqYWxCJRL1snb
         RMVg==
X-Gm-Message-State: AC+VfDwMTdWZWwDVSKg2213qiPovtgzd1xeH28Wr9zNMjgI53AATKOL4
        zERSvlAn/Pk+Q2gv60IRGjcR0Q==
X-Google-Smtp-Source: ACHHUZ5YYYlSgC1V3KRSjRNSOXWVqQWlcOczSmzsen3nujIQLBEGe4Bnnj50uCWaKV4ofo1n52bAFA==
X-Received: by 2002:a2e:7e07:0:b0:2b4:7633:ff0f with SMTP id z7-20020a2e7e07000000b002b47633ff0fmr3270970ljc.48.1687247102890;
        Tue, 20 Jun 2023 00:45:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003f739a8bcc8sm1635305wma.19.2023.06.20.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:45:00 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:44:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
        daniel@ffwll.ch, David.Francis@amd.com, Jane.Jian@amd.com,
        Bokun.Zhang@amd.com, monk.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Message-ID: <6785d220-6ccf-40ad-ae07-4c1cae7c7ca3@kadam.mountain>
References: <20230620045919.492128-1-suhui@nfschina.com>
 <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:37:59AM +0300, Dan Carpenter wrote:
> "Mark the associated types properly packed individually, rather than
> use the disgusting "pragma pack()" that should never be used."
> 
> https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/

Marking the structs packed could be very simple.

regards,
dan carpenter

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 104a5ad8397d..e29dae04f7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -209,7 +209,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -262,7 +262,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct {
 		uint8_t id;
 		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 
 	/* reserved */
