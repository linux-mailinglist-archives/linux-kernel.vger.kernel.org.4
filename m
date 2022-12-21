Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9003D6533A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLUPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLUPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:47:27 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021991ADAB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WMvM3oIiYKel5HPXqZ0wwZClubdzV5QaZHrYn2xq4Js=; b=H4uE0QPetyV6wWmK/W9fnNlXos
        2pHteCy74MP5gpU+YESUl4xuXHRtqxahK3xludCQtQzK9OfPx7qLa1KLs3ELbFpW5I1kC9wGCk8Fu
        mfLAT/rdyCAeILUFWL9GFbqc5S1m40SeI6STM5OAGJV3wWotRcHS07RJVFZdtsNWK08FZh0yuCuS3
        vT0OTlvGTTqDEwV+vCZKMoaQW0BXkl1NgU53OX138Wmvlk708ggE4hCA3dmkWSmr6HTYBO+Vdi6LD
        8z6ZV9wfcjka58WIZIlLC2WUs8XleCxfvahrHIPNtjdf3XKpz6htcRr6Y/kWDDdX3rnh6exvvy0BD
        kktjH1YQ==;
Received: from [177.103.98.201] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p81J8-007ZDo-1S; Wed, 21 Dec 2022 16:47:02 +0100
Message-ID: <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
Date:   Wed, 21 Dec 2022 12:46:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on bare
 metal system
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv> <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 02:51, Baoquan He wrote:
> On 12/20/22 at 01:41pm, Baoquan He wrote:
>> On one intel bare metal system, I can randomly reproduce the kdump hang
>> as below with tick_periodic call trace. Attach the kernel config for
>> reference.
> 
> Forgot mentioning this random hang is also caused by adding
> 'nr_cpus=2' into normal kernel's cmdline, then triggering crash will get
> kdump kernel hang as below kdump log shown.
> 

The weird thing is that you seem to be using "nr_cpus=1" instead - this
is the cmdline from the log:

"nr_cpus=2 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off
numa=off udev.children-max=2 panic=10 acpi_no_memhotplug
transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0
hugetlb_cma=0 disable_cpu_apicid=16 [...]"

You seems to pass twice the "nr_cpus" thing, and I guess kernel pick the
last one?

Also, what is "disable_cpu_apicid=16"? Could this be related?


Thanks for the report!
Cheers,


Guilherme



