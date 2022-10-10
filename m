Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC65FA7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJJWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDDB3A4A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665441503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5viJ+Zb2p3oW579v/fCAvnP1g7/ho/FXg6uX+38eS8=;
        b=FBllAw1gX7jV4j2lwfCEgmo95uxd6pg3MmbLJz/BEbEuRVHMJfWjeSrjdHjeYR4T4DKamm
        lko9t6D0Af9xWCK+kntF95RUlzLkhr2USEmLYQ2vIeLcSlpZ5u6LL1cEjBtq8n5/9l+ADM
        ABDGSZPFod/4/MIojiCirsLOxo1KcMo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-DBGaMAtCMDe7S84P4EHGTQ-1; Mon, 10 Oct 2022 18:38:22 -0400
X-MC-Unique: DBGaMAtCMDe7S84P4EHGTQ-1
Received: by mail-wm1-f69.google.com with SMTP id d5-20020a05600c34c500b003b4fb42ccdeso9624515wmq.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5viJ+Zb2p3oW579v/fCAvnP1g7/ho/FXg6uX+38eS8=;
        b=L7jWs0eZvze2bkx2r9Ldqg/8Cy0MKB+yzOzxajy7pU6hbh/M96oTail02+hncAIuEi
         VjqjA5Qzg/f+KHaKawErOIgQuRtfErYgQH2rHjj85C+BbIWnLcNRTvWHXc9a6HQnRp9W
         wu6LxfjhlkrXvQTKi34xRfhesaCy8ZfMIjRKghauAuAOMof/xarfo5LkuBqGiK6clitp
         DFseGtry/XAoP+XnP5GY/oH36y+S0m1fuT0QXBmJVmdQRVsqgLe70nbCK/wTaiQLJw3v
         /Vhx/zWysYsyWn2nLw6XXEWNsEMYXHOVOWOA6lTaqdoH6URAVrVPqz5q3hCv7PaQwtLz
         QFgw==
X-Gm-Message-State: ACrzQf1UTvXrhXeP/cVUlXYjXwcYMZXZMaRjpympmCnjjU7n8rb9J5uE
        WWs8QaRy5mrJ9BwpyOWo1xWJhWf42ys6wF4u8DQIwpGjQP2BDMHGZf0LbYpEH4POX07K/BBp2Q2
        EvMXZNXRwVZx/y+tDhbYv190=
X-Received: by 2002:a7b:cd15:0:b0:3c5:1b4c:7632 with SMTP id f21-20020a7bcd15000000b003c51b4c7632mr8793549wmj.2.1665441499671;
        Mon, 10 Oct 2022 15:38:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kw7kGqQ8TH8BdTKOf5QU6caDHMMwMUH/VIdiykzpENMGGS+Uk4+J39hrb/ITUTgwCbMp11g==
X-Received: by 2002:a7b:cd15:0:b0:3c5:1b4c:7632 with SMTP id f21-20020a7bcd15000000b003c51b4c7632mr8793543wmj.2.1665441499435;
        Mon, 10 Oct 2022 15:38:19 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id z1-20020a7bc7c1000000b003b435c41103sm21295448wmk.0.2022.10.10.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:38:18 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:38:17 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221010223817.cw6gccru2k35ksn5@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Elliott,

Actually, see Linus' tree i.e. commit 47cc75aa9283 ("module: tracking: Keep
a record of tainted unloaded modules only").


Kind regards,

-- 
Aaron Tomlin

