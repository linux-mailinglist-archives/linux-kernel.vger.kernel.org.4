Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8E73294C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjFPHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbjFPHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:53:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3C2945
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:53:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686902006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9b6qw+LHebz7nR4cWWGa+NO6HGr0qxaMmVU9cknHmz4=;
        b=C7dD/USolukk70IWDymfETxoeF+U+0vqNksrcoHbl1TpuOMoNDyJEERfCwVGeMq6Y7j4cy
        lELcs9ijuLTmoWcM75LSzYxXIqW3LeegkXH8Wu1Ej/qMiMuTHZ25YpJ89fSbHiERQ4E6Pz
        fUcUdfPbKQu3jUPi5cIxOt7GRgVBGBsSCWbmoxsIyb/qJkrMaEoxc+B3nNKaC+gmT8cSbG
        P2RudCqSzQywd5F/KmAb0k8l4dPC33Ly66xtv1Hb6hhfokRvykp3IBIEN0KSSs0Tt0hoie
        nWAAx2g05IYrhM6MStfxTODwZm/eNXXT8DEQfVTlh8rPY9QTJGl5I4+PkGJzzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686902006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9b6qw+LHebz7nR4cWWGa+NO6HGr0qxaMmVU9cknHmz4=;
        b=/N6drVnGjXE3ToifwBluN6n6bULNdI6653PyhAQckRyQ77U+VT1lJEP/i1+vipl3zxatKu
        llWPIjkQD6relHBQ==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
In-Reply-To: <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
Date:   Fri, 16 Jun 2023 09:53:25 +0200
Message-ID: <87mt0z7si2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2023 at 18:58, Ashok Raj wrote:
> On Thu, Jun 15, 2023 at 10:33:50PM +0200, Thomas Gleixner wrote:
>> +			dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>> +			dm |= APIC_DM_NMI;
>> +
>> +			for_each_cpu(cpu, &cpus_stop_mask) {
>> +				u32 apicid = apic->cpu_present_to_apicid(cpu);
>> +
>> +				apic_icr_write(dm, apicid);
>> +				apic_wait_icr_idle();
>
> can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??

That would not set APIC_DM_NMI in delivery mode and the IPI would be
sent with APIC_DM_FIXED.

Unfortunately we don't have apic->send_NMI() ...

Thanks,

        tglx
