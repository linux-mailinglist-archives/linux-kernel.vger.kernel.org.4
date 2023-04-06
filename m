Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93356D9949
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbjDFON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbjDFONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0389ED2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=aZhN1NC/iWWs/nmzETinltHhAezLhQDbgIzpvQxSWycMVSuxgGVvVcvmNr6gV/6TrwKrlR
        H/UpujZANJOXhiL0pyb+Jdl+gBaLUXFN3Vxuybe0NgK7HVpfqujLcfvS3Ryp88SzLPd/ho
        AL6MENLq53/v3AJTB/yPGoHczRXQdj0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-LAtCg5MEPZyaVmDL5jcKRg-1; Thu, 06 Apr 2023 10:12:00 -0400
X-MC-Unique: LAtCg5MEPZyaVmDL5jcKRg-1
Received: by mail-qv1-f69.google.com with SMTP id j15-20020a0cc34f000000b005c824064b10so18000239qvi.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790320; x=1683382320;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=ZHc920xUL7/tc8nF0Wi6ebJb2GqDCD1SOqmbCJe1dse+oXkbvfnCyEAb0k2SugV3nO
         AaGT15YBXwly5fHjVzMKTHs/HpXYDIplPeb6S1BOON4pHU9kFK7QW0IXxkYPC81wgk8y
         ghkoWPjf9/gtMWR/o7HGkKUVfbE8UcULqIHHaGFKPPRbwI7kL8XgLqq52Nns7GrMsoRV
         tYGcZffIUPFnBMiIwDpfNvIq6oDTKbjAPH85YvuOaCVJOMP53biOx2w0pi2plE6McVkm
         bzKrN268sA5DpcmZmD9JWaoBcikmNjMAm6WSUoXcqnwNJdTjwmbJFX7DUkH1LuQOwH+T
         QIKw==
X-Gm-Message-State: AAQBX9dJOwjHuu2fx8eFxHrP4NnwiUg4gl0pAsh3LRaLohhPybC7iJP3
        fzO+iLQBD/Qc6QxDMjur7/R0RdzSR5xMlBDpw9EKdpgMrN0K5Gzt4WxBSBNSVpvOXLjq1bChMc0
        z/KIsM1okzBAD6p++5DoIfIOg
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151664qvd.44.1680790319574;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdFg9Rpod34ylmYUyAnCfxfiKdtnShPJSS+THNG9On45kotrwTmF6ARLq441OR3LQJbmn9Kg==
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151612qvd.44.1680790319253;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cf6cb000000b005dd8b9345f4sm514523qvo.140.2023.04.06.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:11:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406133805.GO386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen> <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
 <20230406133805.GO386572@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 15:11:52 +0100
Message-ID: <xhsmh8rf59k2f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/23 15:38, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 01:45:02PM +0100, Valentin Schneider wrote:
>>
>> I've been hacking on something like this (CSD deferral for NOHZ-full),
>> and unfortunately this uses the CPU-local cfd_data storage thing, which
>> means any further smp_call_function() from the same CPU to the same
>> destination will spin on csd_lock_wait(), waiting for the target CPU to
>> come out of userspace and flush the queue - and we've just spent extra
>> effort into *not* disturbing it, so that'll take a while :(
>
> I'm not sure I buy into deferring stuff.. a NOHZ_FULL cpu might 'never'
> come back. Queueing data just in case it does seems wasteful.

Putting those callbacks straight into the bin would make my life much
easier!

Unfortunately, even if they really should, I don't believe all of the
things being crammed onto NOHZ_FULL CPUs have the same definition of
'never' as we do :/

