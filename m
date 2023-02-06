Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F868C55D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBFSHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBFSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:07:07 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9A23115;
        Mon,  6 Feb 2023 10:07:05 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r3so2812786edq.13;
        Mon, 06 Feb 2023 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/180nd6PQXi3CnBsI9/SGgqyujAYT8iG4l6zuBW2bg=;
        b=f7I99ybdPkKVTn4MSow6UxAV1DpjXcdrEY+8vQtEUlb/P18vYEMUkPOqsujBEapwGs
         REiiTamXNEuMp5oeyNje5KdZu2mHTn1kiZCPZ8iQXxkM6guU//X63x6/1+2ufYEYPA8y
         /10AMPOAvk42INsQtC1KqBZpjN44TDUbNZeuLOS7OHkBOt3PWdQUC5k/fVB2RAIoEdW5
         9vrbBMBvlqk9gLpiaM6NeQuHiJXvvq7TgYb4ZJ1BeNgifzo1eBIQPGH9Z+amTYTAJRMo
         OFJQD3c8fMbAvEm6Gf4HW7ZfPbOxC34wqK07uCEuefGm4kc9Bc2zt075kXRPdVSYWGf2
         q2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/180nd6PQXi3CnBsI9/SGgqyujAYT8iG4l6zuBW2bg=;
        b=VrPuSg4+UEiApvA0Oq19kQTDBeiJG4UfgW0xRJO5TV5025Jqy+rYJJ2yyWuFJRoFF5
         s82R5JUeFPBX6iUaxYYFFb1eXHHx49WQ61CC/J98iRo5MqUwAiJaX2JSa9kfN627wNwg
         gqfXwemsC2paP7hZ7DCNlTTe2NM9JFcD0Uy4dKy9n2GXSIO65cWUNiXnGvShGYKGR3EQ
         PbvxkqT2Qf2M4xQQmF3CGzMJnLH/hgxeqT73JiUBPu+UKT8yOs5kFyBXwkl5xPr+cAqU
         pdrDRWuqUBJA6TXtBrB0n6swaI6fmJfSfD6la4opDlTvNu8fONpfPqcTpFpPe7zD1i10
         QbeQ==
X-Gm-Message-State: AO0yUKWoLJNJhhsz06ZpBYL3Z9CwbLV/He09uPgQ2adsBw6LxKvHkl9v
        VDq+T540IBBhXsSF1uMj3pI=
X-Google-Smtp-Source: AK7set++i8bypk9HDCZcSpM1KxhgBSRKCPWUtOCLf4fG2YXpHtT9Ys2W0KORYhaiXqk5T6ylH8LeCw==
X-Received: by 2002:a50:9e42:0:b0:4a0:d0b7:1fbc with SMTP id z60-20020a509e42000000b004a0d0b71fbcmr535344ede.14.1675706823958;
        Mon, 06 Feb 2023 10:07:03 -0800 (PST)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402348400b0049ef04ad502sm5354240edc.40.2023.02.06.10.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:07:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
From:   Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <1dbc9402-5baf-4a92-96b3-8b3a9c108f01@intel.com>
Date:   Mon, 6 Feb 2023 19:06:50 +0100
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF4E5F98-A2C5-405D-B538-1AD789E4F989@gmail.com>
References: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
 <1dbc9402-5baf-4a92-96b3-8b3a9c108f01@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 6. Feb 2023, at 18:10, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 2/6/23 02:39, Jakob Koschel wrote:
>> If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
>> 'tmp' will not point to a valid sgx_encl_mm struct.
>>=20
>> Since the code within the guarded block is just called when the =
element
>> is found, it can simply be moved into the list iterator.
>> Within the list iterator 'tmp' is guaranteed to point to a valid
>> element.
>>=20
>> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
>> ---
>> Linus proposed to avoid any use of the list iterator variable after =
the
>> loop, in the attempt to move the list iterator variable declaration =
into
>> the marcro to avoid any potential misuse after the loop.
>> Using it in a pointer comparision after the loop is undefined =
behavior
>> and should be omitted if possible [1].
>=20
> I think there's a big difference between "undefined behavior" and
> "someone wants to flip a switch to *make* this undefined behavior".  =
My
> understanding is that this patch avoids behavior which _is_ defined =
today.
>=20
> Is there some effort to change this behavior across the tree that I =
missed?

Some background information if interested:=20

If 'encl_mm' was not found, 'tmp' always points somewhere into =
'sgx_encl'.
In that case it is not possible to match 'encl_mm' (if 'encl_mm' always
points to a valid struct).

It's still used as a 'struct sgx_encl_mm' pointer even though the memory
it is pointing to is something completely different, which I would argue
is undefined behavior.=20
(I would argue not all undefined behavior is automatically exploitable =
or
causing a bug)

[1] shows some effort on removing any use of the list iterator variable
after the loop, so ideally it can be declared within the macro itself.
I've showcased a similar case to this becoming an issue after reordering
certain struct members in [2].

Some more information here [3], [4].

>=20
> In any case, this patch also kinda breaks the rule that you're =
supposed
> to make the common path through the code at the lowest nesting level.
> It makes the common case look like some kind of error handling.  Would
> something like the attached patch work?<sgxmm.patch>

of course! Actually the way I would have preferred.

I've posted several patches fixing those cases all across the tree and
always got mixed feedback.=20
(I proposed your way to others and was asked to change it into the
way I posted it and vice versa).

I'm happy to change it to the way you proposed way in v2 ;) Thanks!

- Jakob

Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/ [1]
Link: =
https://lore.kernel.org/all/86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com=
/ [2]
Link: https://lwn.net/Articles/885941/ [3]
Link: https://lwn.net/Articles/887097/ [4]


