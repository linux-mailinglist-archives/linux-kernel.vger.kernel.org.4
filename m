Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52670FF86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjEXU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEXU46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:56:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11812E;
        Wed, 24 May 2023 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684961802; i=deller@gmx.de;
        bh=RuuhT55mt/C93pVbMB7MjnuUe2g516L6GXgAlvUtRiU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=axf4bK2RwknNKEo9wlfHGam2vXSUuNWZ9HB/E3JM/oKf6SZhG1+sPs4aCFvUkN8yY
         xqfHxoIaB2X+Ej9TvB3POBXUIAaMpXIhrbekBCElDKfebvtTpNz/ILs07IwxBXm/Ti
         +8J6SZA1hsAdq5g1OmnoAy8aTCsBLlwc+fSOY8PFe9/e9tcJwnGBtCm4Jv0Vtfg6eW
         uxmaFjrTs+UU/mOAgCA8ujBkEwTk58bkB3H77DK6sYEhJXmrc7GwfpW6g+wFmwIUq1
         FFbyaoIkG7xgAzHOx0ugj0vD1OBEJFTPNwsyHLWI1emkyVhnMKVji0Ri8Rlg8r1ORi
         D/Ie7ZZNAJYOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.4]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1pm9q502x9-00P4JO; Wed, 24
 May 2023 22:56:42 +0200
Message-ID: <f97510ab-a1c0-ea96-5d81-69fbd10a5269@gmx.de>
Date:   Wed, 24 May 2023 22:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] arm: Fix flush_dcache_page() for usage from irq
 context
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
References: <20230524152633.203927-1-deller@gmx.de>
 <20230524152633.203927-2-deller@gmx.de>
 <3e131821-7665-47f0-a8a6-44b3e4d7a88a@app.fastmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <3e131821-7665-47f0-a8a6-44b3e4d7a88a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NzLqJJsuiRaAL1WmQPOsId51ZP3sgOpqQl9vs4Vpk2MjybabwQF
 EhYdWXIP/fJGblHPgVA71Lsv0yi8cZHobgjf5XoLsweu8PKwvJ055MpH/PJF68KaRQgsMhA
 NeBY5FXbvmuWMfPqYIRbbWzcYk4Ii3JOL8NiomPJEjsbqMJCmNy1jDge3kM/4lBb5M9wK/2
 jkJ30Vw43rrGiIQWRv0PQ==
UI-OutboundReport: notjunk:1;M01:P0:LuYL/VzftTQ=;oqSsiFvks7AvTGvGVRWhMkKCt5H
 8ze/UcWSwE4y64EL4kQ/KnFRX5EIaHI3RYF9uWUN9g369746Jwf4cubjjMb7pF/rCVqw4xetf
 CczdmHu5Zf4WkmwBAPNJO8oGLfZ4qqs2m0OD7IyIPiY5yLPSOgH4dIhp2sHUxpyicOKJLqAeB
 CDVfeBP02CwvoWT9WxeZ8VD0jDEgompeTss6H5/FQudtaxeaix20wfWbDZG0hy3R1xkAkaNaB
 5KB22h9GZVxPF9ByRskADJsTWa9U7dryDQwyHmC3ZJt0iprEWcmmYGkF+z0lU3vg1skGGTnJ7
 pmh9wkJshq08+NplgShj6uD5FYyaWi4ec2ejzvUmImAO44OWKvA8dNdCK97BOPYXubAONYVZ0
 MtzFlmIvSfh1aqQ5i74s6MedSp6Uy7JbNk7YzTaAL96zPsD6KrrQQpMo3sekcFXCGbHW0bQKd
 IV2tIk8bPdFo2SYPjNPUfM6JOxI//kQHoVrclRbnI9HGtPr/t2jqpwNhhWiVN8zXmwgtdVIRM
 bw1JJdQwGRCg0PBd3HBUeHObgOrBLi5LynsZiWjvX+eCATGn+1vi6zhF5iC0YKH3+lfTKwuAz
 qwVipSYS66cIXGdeAAJcAAs524HpKWEt7+eS9+w1jsyXo6YEMIKDwgQoMa/o1Wowmp23sS+i2
 sVRzTHK5qZo841TrocPU/88zGZHN3zjso0TshS4ZugGug4cwbAXfbm663o/K0BOpfcLnmeivr
 ctGRRp/lTtpJtODC0wC4KlMyAbt8/yuUhGFfP0i8ZnpSqxOCnuPD/cbXRAnwBmcaoLXUc27HV
 PgDfFLH1w2e/B2uBRiHlIaD52ntZk3rEj8VrSYp+fPXte9tE60PmnSARrriOyY9UCY7UqGYhX
 JgB+DLn4zzHf+WR5I52GzqEXMFCqRWaLVyInZYliPua4SA/VGb7ojYTi7ojmMVzqyP4nDFLwu
 1QmtAQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 22:00, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 17:26, Helge Deller wrote:
>> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
>> disabled, e.g. from aio_complete().
>>
>> But the current implementation for flush_dcache_page() on ARM
>> unintentionally re-enables IRQs, which may lead to deadlocks.
>>
>> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
>> for the flush_dcache_mmap_*lock() macros instead.
>>
>> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
I assume it's picked up in the arm git tree then.

>  From what I can tell, the behavior in aio_complete has been
> there for over 10 years, since 21b40200cfe96 ("aio: use
> flush_dcache_page()").

Oh, then those arches are broken since then.

> Others may have done the same already back then.
>
> I also see you sent patches for nios2 and parisc, but not
> for csky, which appears to need the same thing.

csky doesn't use flush_dcache_mmap_lock() inside it's
flush_dcache_page() function, so I think it's not affected.

Helge
