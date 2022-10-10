Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8215FA7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJJW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJJW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381474DD2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665440760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYDszS9Twkbl1aJjHnVtMr+zqtaXoXBzM/5HeDn8Wys=;
        b=iZTGMZIU7DnjXJDbrV4NKMmBEiZ80sKaskhf1U2dPM4RHG5IcVyE/2Yjv/HIHAKRHdtsco
        eDJbjEB6iICBPKw1P/KEcs3c9MrJAYgaq8jM7WJaRfQrgtcCtayvs4l4cj2OtzT9AsUXBN
        HwotkHkoXT0hdsp1LeZF+VL/DoFAyjs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-yN6AQiyXM_CQPBp0eFPD0A-1; Mon, 10 Oct 2022 18:25:59 -0400
X-MC-Unique: yN6AQiyXM_CQPBp0eFPD0A-1
Received: by mail-wm1-f71.google.com with SMTP id h10-20020a1c210a000000b003c56437e529so1037714wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYDszS9Twkbl1aJjHnVtMr+zqtaXoXBzM/5HeDn8Wys=;
        b=Ym0gFnLVdVCxiUah4M+qEHUWrK1RUD1KuvWUCBkiRa0voWR8j40KNXNQct2glLM364
         EtnoNesHpd+m1ljEdPMtZoPqIMYuDMWVx8F/WDgHKYzUiZ1aNdamihgQjQcwhSbP2JYn
         tsLMgktyW7Bx15GQ3HYmz9YgKJ85kbGr8t6yjfvP4NDPkbo/hak6MWN5DmtZBIAsazCE
         3taDJIV+LlbXUE14x3a6zLD1t5B6HvXQ/9MuNWpZC6OCgiTdGNNqQpj+EluUwSWXzKZx
         apzKvQxjTBWJqn1nuLFETLgFGovsdTFETZKDbXAeuZ4D6MBdDdI7fCBAmJ+mBF91hIZ3
         FMUQ==
X-Gm-Message-State: ACrzQf33HW7hy0X40nYwZpdskkhHYzYB1gNL/swQVDoMqA0aGwiuEbxS
        K/72LEUBMHKqk/K6Ye67zlNBHI3l7eCuOieUNoKiK60xqKdNCgCpnqzhJOg3hmA0hUzGlRaWoZc
        8NYIjBD2DoMtgpqj3+2l9PqI=
X-Received: by 2002:a05:600c:1910:b0:3b4:bb80:c95e with SMTP id j16-20020a05600c191000b003b4bb80c95emr13376212wmq.54.1665440756035;
        Mon, 10 Oct 2022 15:25:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EytGIstdUr/SmKOaCQyEfqdbYN89t4k/lTEhu5ubbuFhs+FwISjKmA8HLWYraVdUlMpgruA==
X-Received: by 2002:a05:600c:1910:b0:3b4:bb80:c95e with SMTP id j16-20020a05600c191000b003b4bb80c95emr13376208wmq.54.1665440755824;
        Mon, 10 Oct 2022 15:25:55 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b0022dc6e76bbdsm9913034wrs.46.2022.10.10.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:25:54 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:25:54 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221010222554.4ydgxs2j22arwje3@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-10 15:12 +0000, Elliott, Robert (Servers) wrote:
> When repeatedly using the tcrypt module (which is designed to never
> load successfully), the "Unloaded tainted modules" list grows forever:
> 
> Unloaded tainted modules: tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 padlock_aes():1 padlock_aes():1 
> isst_if_mbox_msr():1 acpi_cpufreq():1 pcc_cpufreq():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> isst_if_mbox_msr():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 isst_if_mbox_msr():1
> 
> Some other modules like acpi_cpufreq() are repeated too.
> 
> Maybe this check after the name comparison:
> 	mod_taint->taints & mod->taints
> should be:
> 	mod_taint->taints == mod->taints
> 
> or shouldn't be there at all?
> 

Hi Elliot,

Sorry about that.

This is already addressed in linux-next:

commit a0830747f4e6810876e5f5329ce941e258e13a22
Author: Aaron Tomlin <atomlin@redhat.com>
Date:   Fri Oct 7 14:32:44 2022 +0100

    module: tracking: Keep a record of tainted unloaded modules only
    
    This patch ensures that no module record/or entry is added to the
    unloaded_tainted_modules list if it does not carry a taint.
    
    Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
    Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
    
    Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&




Kind regards,

-- 
Aaron Tomlin

