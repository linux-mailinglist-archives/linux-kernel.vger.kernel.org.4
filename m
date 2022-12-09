Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99C648265
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLIMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B581FCD4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670589168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wx12DY/bW1ohcBhXEaD09HWTnTluJbFDvZtWQ3v9FbY=;
        b=J8Dfr/QstbfN9dwSVnBrGYb2OgAMAIRVdi7GF/o0YbUiJXPgDOPVM72gsApH0/cYSaB3cT
        geOVl/Z5x8gwKGHBL66dcmHVTAB+27bvQYT90pAm6O0JXT6gjdO28QABE90fHTLY0Xw1iZ
        +bsyuPcW7cz5bHudtMrU0YyEL8W8QoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-Kmc4sVb0NpKV4nAASgSwwA-1; Fri, 09 Dec 2022 07:32:42 -0500
X-MC-Unique: Kmc4sVb0NpKV4nAASgSwwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0F95185A79C;
        Fri,  9 Dec 2022 12:32:41 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9385C2166B2B;
        Fri,  9 Dec 2022 12:32:37 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrew Waterman <andrew@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
References: <b1dae947-d52a-d28e-5ddc-c1ad6d29828c@rivosinc.com>
        <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
        <CA++6G0D8RdjgvzQf-gMdakcF-Jj_PMjP=MBtAbSC0Qcu_WrTTQ@mail.gmail.com>
        <877cz0nbce.fsf@oldenburg.str.redhat.com>
        <Y5MoPdYimQtqQvkM@bruce.bluespec.com>
Date:   Fri, 09 Dec 2022 13:32:33 +0100
In-Reply-To: <Y5MoPdYimQtqQvkM@bruce.bluespec.com> (Darius Rad's message of
        "Fri, 9 Dec 2022 07:21:17 -0500")
Message-ID: <874ju4lpum.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Darius Rad:

> On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
>> * Andrew Waterman:
>> 
>> > This suggests that ld.so, early-stage libc, or possibly both will need
>> > to make this prctl() call, perhaps by parsing the ELF headers of the
>> > binary and each library to determine if the V extension is used.
>> 
>> If the string functions use the V extension, it will be enabled
>> unconditionally.  So I don't see why it's okay for libc to trigger this
>> alleged UAPI change, when the kernel can't do it by default.
>> 
>
> Because the call to enable can fail and userspace needs to deal with that.

Failure is usually indicated by an AT_HWCAP or AT_HWCAP2 bit remaining
zero, or perhaps a special CPU register (although that is more unusual).
It's possible to do this differently, but every mid-level startup code
will have to replicate it (the libcs, other run-time environments like
Go, and so on).

Still it's much better than executing the instruction to see if it
traps, so I won't complain too much.

Thanks,
Florian

