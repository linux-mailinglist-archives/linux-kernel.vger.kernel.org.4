Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C434D6378EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKXMbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKXMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:31:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC1BCA4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:31:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5so1208818wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JU48m0AZrUyT2++X8e6FIEgULoXPLA3Dizh2n0L4e4=;
        b=nJ6yamWSxD9zSs4XqTzdk3DVALEFwHbQ3n1O5P4YrQfjn7uW1WBF2+YyK6k3jZK4MZ
         etuI3RTbnbLC0iU9XyYt8yClLsJlp9Viq8LoTQyTUtNJbeB4JDj9yjLFGfdox3Pc5Typ
         l4XQ/1dSAgwU3MOnNfO2Pn8vl5jEQ5CzWgWliSG2++AriiPRCYvAeU4swi6mAZ1559/3
         1X0yRZSjGVAfN8SvohzUT6MS7YY0GUnjSUdvknH4RNjKimLWcf+Y8pOFxbuHwV08CGdW
         zBccIBYo8UHXCrf3rXKWno1qTO9YJ7Qh/KNDKAM16F+uB4vNag3UrdygWjjUaQ6fMCtw
         QIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JU48m0AZrUyT2++X8e6FIEgULoXPLA3Dizh2n0L4e4=;
        b=IZwJ64u7G3QLBB1JtW4+Kyf3+1TzmO7HE5r9BnuiRTa8LFeGQdT1pv3i7uEusvMXGk
         y8E+cXmLFTxDEMf3CKzAG1PCUuFYZO8FW0UfQZ/gVRvzcFzUE3tRr9Erlb4/VSPkYbeP
         mJPAE4ugIDa4A2w1HZEGU7nu4WZCZwiA7Lo1qQQYsZ0S1mhsmJBRTyJ4HlF5qgKlEUrJ
         XwLjTDes1BtvKApGBdVRAW5LxfE0QDCs3cIMiexyhGMc6WzEzF8cYIcKoE1ko8RP2lg6
         GGLegCUgug3aZPU3kLjfC1kcjH9nTvniYQGZI6hhDyZvdvXbXDxbuhj3YOB0U87ls0Hr
         e7RA==
X-Gm-Message-State: ANoB5pn5cPLiP2bi2lMNhEmtFvGBbACOxvE1xQrXbVPCPMQ1a/thG50o
        0aWng0MQAtXQFC7sjtoH3YThEQ==
X-Google-Smtp-Source: AA0mqf4ONt6wFJvL1KocMtvj2hyw+ebBrslVU+JVZ/egvfjZFFv6tWRwHRPExuFK5D7UQ6tFo8BDWQ==
X-Received: by 2002:a05:600c:3d0c:b0:3cf:f66c:9246 with SMTP id bh12-20020a05600c3d0c00b003cff66c9246mr11340007wmb.27.1669293096142;
        Thu, 24 Nov 2022 04:31:36 -0800 (PST)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4243000000b00241e4bff85asm1180970wrr.100.2022.11.24.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:31:35 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:31:31 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     samitolvanen@google.com, nhuck@google.com, ndesaulniers@google.com,
        kernel-team@android.com
Subject: Bug: MODPOST mismatch ignored due to LTO
Message-ID: <Y39kI3MOtVI5BAnV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It seems that enabling LTO breaks the check for section mismatch in modpost.

If I create on purpose a mismatch here's the output without LTO

check_section_mismatch()
  fromsec=.text
  tosec=.init.text
  sym=kvm_arch_vcpu_create

=> section mismatch in reference: kvm_vm_ioctl_create_vcpu (section: .text) -> kvm_arch_vcpu_create (section: .init.text)

While with LTO:

check_section_mismatch()
  fromsec=.text.kvm_vm_ioctl_create_vcpu 
  tosec=.init.text
  sym=kvm_arch_vcpu_create

=> mismatch ignored, the section ".text.kvm_vm_ioctl_create_vcpu" is
unsurprisingly unknown

LTO seems to append the symbol name to the section which is a problem for
modpost.

Is that a known issue?

Thanks,
Vincent
