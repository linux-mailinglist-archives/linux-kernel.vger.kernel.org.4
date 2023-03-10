Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429296B4DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCJREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCJREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:04:01 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718A18B19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:02:08 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so3144763pfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678467728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsfusCjCc210/E/HGWku9xtNSBTDQNBkrHBBfjpUrgw=;
        b=iSsFjWMG2Aib1vaWXXXWI2iTe/SiUJtBUSN9QgnyrwyhyULkmAbGuI8a+avapxsguv
         1uC2MT6ZwTj38FKKb/jWlrTWb83NoGtgF0k3Xwg6pkYfqOx72+77LIBm7vYmoWgLh3ay
         FP4oDTPKxGwqdw9QCIuCTo+MEyyhO+5UTL2/851s/1suiybpfRcS9QBN8Cb4bw55fsfb
         zBRyQcr8o1NL+WffxroVeWRAV5e77FCruKZhQQrcYERI5Mb2QEPtdW5/YdqWkO2HYgcI
         vAqMaeinIb1va2p0Vy7k/sh59W/GfJztes2RTWFdOHmCLyeQokwkHKVqJNl2Z72xmFOk
         ihUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsfusCjCc210/E/HGWku9xtNSBTDQNBkrHBBfjpUrgw=;
        b=kiHD6dRmj2Asx9jp/mCiThZHp0z0qAj/ZUX4Zx4n52qIeZPg1RnB2vvf7NRwba7+UC
         hCPyB4LMlbqpX2oVwyH2Y1eJoLH8MCpByQXWJJFw0UTmJ47YY9tYlh36X89GpTDEHGkB
         lOMF7p4BxxonRcgTzsfVW/AIwXoJSPAOy70y7t0q10EpdAyDzNaU2co2r0Yoa1Xm7XwG
         ANgMH+Z05EsS/sH6LjGbrGR7EQSysLvesebFrYpUKl7EYe99OpB/B0dOPYisGJg4HB7z
         IJvc+ynT2rt424m+7Fd8be6IJ5T4qzR9b5jYYiFluC/itSlqkXlpK++TTyNecq2IOYbt
         KEQQ==
X-Gm-Message-State: AO0yUKXLtfl3s0TshtMe+7uYZBNi8B70LClpX6O3dnUIQvR1PL+ilIjB
        /37w9MsV/SdVkQkNmJ1A/MQ3vbX+idw=
X-Google-Smtp-Source: AK7set8hRm0G59X8lRz83J8/HnJ38K5SJesk7AwRkLXo6vd+rmcDG9eZZth6Gmi7fMS4eOegOQzUDud/nKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4f4c:b0:237:203f:1b76 with SMTP id
 w12-20020a17090a4f4c00b00237203f1b76mr9643928pjl.2.1678467727921; Fri, 10 Mar
 2023 09:02:07 -0800 (PST)
Date:   Fri, 10 Mar 2023 09:02:06 -0800
In-Reply-To: <7b763dae-e6c9-c269-2675-907430bbf21c@amd.com>
Mime-Version: 1.0
References: <20230227084016.3368-1-santosh.shukla@amd.com> <7b763dae-e6c9-c269-2675-907430bbf21c@amd.com>
Message-ID: <ZAtijt0srZ6b21Zi@google.com>
Subject: Re: [PATCHv4 00/11] SVM: virtual NMI
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, mlevitsk@redhat.com,
        thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, Santosh Shukla wrote:
> Gentle Ping?

I'm slowly working my into review mode for 6.4.  This is very much on my todo list.
