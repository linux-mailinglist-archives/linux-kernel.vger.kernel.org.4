Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75E5B9404
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIOFpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIOFpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:45:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D59B8E463;
        Wed, 14 Sep 2022 22:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663220684;
        bh=PV7fH85MRA4yc9AjgyP4hdElIOcHCJ5CFQAPoEX99J0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ktfV9dAVDv4xo0RomC6f0kSSOEhok4v4xnQ3yW/kx/uuEsMkJHaT1bdQ5AqC/22wt
         NICRODoW4i/7tvD50msK9qcTloBeni8hdJ6LdLnGfMs6SAjTe7C6ga7MQZnLUC3KNP
         afsekUe1FDHMq4e5n7vXVq/zp+O6sJbojrEhhp94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.140]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1pUuwC0agO-00wYKm; Thu, 15
 Sep 2022 07:44:44 +0200
Message-ID: <86318454-d5cd-3787-a88f-41be40967c4d@gmx.de>
Date:   Thu, 15 Sep 2022 07:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] parisc: Increase the usage check of kmalloc allocated
 object a
Content-Language: en-US
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Li zeming <zeming@nfschina.com>,
        James.Bottomley@hansenpartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914060428.4039-1-zeming@nfschina.com>
 <1668528.WaZXzWfjLs@eto.sf-tec.de>
 <3a72852c-2f28-2916-f02c-b52cb06efd7d@gmx.de>
 <7266457.TOmriZnqnj@eto.sf-tec.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <7266457.TOmriZnqnj@eto.sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/VEdP8sMnEu/1h9MXY9piRI2fM98LLscHVjUzRkuV0T3xN/2Qcv
 VeggksKCNaZTxpf2266xe7gPBWjUIplJydtqpumHhS70Pgupv2+Ul0ihBPOVfr++NM2yJeP
 DUTADUWNOoggGeh/48yovNuNN3EbLQ7m0Euji+tPmdlikx6oGY+Y0fcgb3BtJmjdXbMvjK8
 TiqvNRQBkoLyC/TWX75Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VtsPpm4if60=:ejMCncX9nGolt2ipKKd1M0
 VSks4f3qsiURUrpunJtS9+tlJXKaI6g6EaQnzp6iRuk1KLphBPvn4xguT25eshP78P/ieIqVE
 QxibFctjhjmbtTFoELel9Xq16UXytk+O9EDII5qj/72WWQoI0HvZMnmeMGYE112sNH/QuxgSl
 5rqaWW9BpOfRf8PmLo5I4odoLUn/vt/raXRxUwI9CTLbRsEGG6J6u/6g1Su39kTbHMxYDGzWJ
 d89yr1H5fO6NVGtj3EJR5/qIPscZ+x44M/0LZAG3+IImzHR652T4kFWtqaGVtQRFt53rKfNN8
 l0cQQRRV6YgYf+YgYinQTaEjjmxXO1EBh3Ag6NeMFjUZzxtL/N+jhbTuv2X3lPtH7I7hbu09k
 bJlklMfJdagG4g/OkblTeuvn0tYsUBedk8wLVKDNS+lEvu9OkgQ+1XX4J8WhPVjgwnJ4Nvh1K
 SUSofcul33UdYS/XYfQbrTMjR0uHJwbR3ayyfE4nQYLqAVPvVb87MbXBJog//HSh1ocMLcXRo
 5/90fUgPL9Q5+LUXv6DOtyPgvtkF9SbZqVNUdFvgOEHQgsoRBfIBXkdHtt8+NyBuaL2dtViBB
 9iHusajuCr3ahrbkfw0BfJ/OboizUJMvUYXPa8mL8234iz/UPj01ydw1f+Ykp6AE1HhvDRp+v
 t2VTYGCUE92FzuI4k0cA79AQV8ywmv55yZdZtLlm5Gygw13Q8FK+LMxd87+JWiNUThvl0tjSE
 3W0x6XHNpLV3Y/zFgCLWjkdqxpUxfsxYbIF2d9JPvm9vl9UHnEAX0XthA1s77Hi3pyog4fCJa
 bN76dAtLD+dwEDlJiF+8y0BTijhc5MuzSrtPZF7T6J5nimVuQU+T+GIeW3vNDVpXKjVZ016WX
 GHuAzb0Ne2aPKL607vmXoJUpgTORP0OH1YaY8wgT9PbWufQcs8VxQc/93thU4yCZHKwHN0Cpl
 dFO0NXy6xct+jS1zGXiY1jMxokMVblcFBi3WdNO5fa3HaoGGuDs31o+8ywIQS19poYOWIsJ0v
 dmS+F2WGkEKyCBlkp9P/44Rw6kWr9niRhoPiYBIdbYXV2PquUiogZ2c9WrI4J4u1zuhANhogq
 4IGpAevt+nyU5hHH44as7JZ4VN7gVBHz6rEz1WWxcxWW+bBODJMkI7AeHZLSUfGStNYVu2JXg
 0BQwrf7VPtwUGt11UoDMVPt7De
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 16:25, Rolf Eike Beer wrote:
> Am Mittwoch, 14. September 2022, 11:04:33 CEST schrieb Helge Deller:
>> On 9/14/22 08:43, Rolf Eike Beer wrote:
>>> Am Mittwoch, 14. September 2022, 08:18:19 CEST schrieb Helge Deller:
>>>> On 9/14/22 08:04, Li zeming wrote:
>
>> Yes, your proposal is good.
>> Anyone want to send a patch (with a small comment that kcalloc() will r=
eturn
>> at least the required 8-byte alignment)?
>
> Done.
>
>>> And these functions end up propagating an allocation error in this fil=
e
>>> and it will never reach kernel/setup.c, which seems bad.
>>
>> That part I don't understand.
>> The return value of iosapic_alloc_irt() is checked afterwards, but you
>> probably meant something else?
>>
>>> But I guess the only point where this really can go wrong if the PDC
>>> returns an absurdly large number of entries.
>
> What I meant was that if iosapic_alloc_irt() fails, then iosapic_load_ir=
t()
> will return 0, which can either be "nothing to do" or "error". iosapic_i=
nit()
> is void, so even if it could detect the failure, it can't report it upwa=
rds to
> parisc_init(). Which is the same for basically all other *_init() calls =
in
> there.

Ok, I see.
Not sure if that needs fixing. If the allocation fails we will be in troub=
le anyway :-)

Helge
