Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7A5FACDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJKGda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:33:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF8895D7;
        Mon, 10 Oct 2022 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665469999;
        bh=qn+SZdvakhDX1IBq2SStvMbRkm9jyeNIq89B5EkZINQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Qrvbdd5MLjS2vF+q4GFW614cQwWh+zX+iSrEMmKSzsUnmwGTmccPV33XdzkF1Jn2M
         zbDeVjN5fWT0p5dXCMNDK6ygTJPzVJRpzWWFmP0NpoFnp5DqAcjS54wUt1mwDKnP8x
         +SFMwyIPrAh8vwoQG8LVC626yvXgbBTztofqFGBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.132.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1pDTJd3p9H-0153g3; Tue, 11
 Oct 2022 08:33:18 +0200
Message-ID: <cbb04b94-2345-08f8-5d6f-92d20d623055@gmx.de>
Date:   Tue, 11 Oct 2022 08:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v6 5/7] treewide: use get_random_u32() when possible
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Cc:     linux-parisc@vger.kernel.org
References: <20221010230613.1076905-1-Jason@zx2c4.com>
 <20221010230613.1076905-6-Jason@zx2c4.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221010230613.1076905-6-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bZRZq51oYUetpQVixIHO78+7hcEbZZf3a3uefb9sg9ZNAQ+z+aC
 cMV2LduzVBBzAvGLRRrqtBXTaqR8uQZwj9H3YH2EwuknXU0HN68djFYMFUbcOQnjt87SClx
 gcc3+H419EljfqPD7pe7alfoe84wKqsnvRmGf7pcubVHNUnJZEN9JbuDb8xElJHOvQKktue
 sj6psqp4yTu0Jdig3Dpeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:60IcFl1Ya0E=:qvqV+3vVDd1+fCPWc7aCAv
 teiJ0KCNsMG6ZQ+DqT/nssQMPoHAPkcqJCUghFzh80t+0z34ddc6NLYboCaur1hA4uy3ejpqv
 LWq4sUAa3E5rc0hG5+KyWYmOhPk8Ml7fnkYi+elMjrryTKrpYMCHin1dV10hAqd3jqnWCnvuw
 8AQSpmt+eY7ZfEjRvSdsZzXbPE8V9MK7b11FQ98iZjKa7kQlD32v2wnDEnypSo3KPg//q7sbZ
 +i9JNkZVqoIgUUVzBx85B1+JFs/gMqzb0bKT4t2fl8GB7J8LHiZshGw/wIcv/1qk/4F8syFwB
 Vs31e+do0gA8lNZIPBj2F+cPPqLTguMhB92yyIhnhk7yD2wwNXIC3dyhEoLGo3KSMvf7KW8zH
 v6LcPwspqwe21DtxlUDZKxwSR0dQ/BSFZOPWtsi+YGZojxpwwiqXF+GKwhb2tSWhX4Izz93b1
 f8nRkem65F3dWRuUkPthEXAiPNZLMzGytCt2BgzomFBfg7vc1BcxoCBNkddpq3FFeB89TCl22
 Mox+dGPGDK6PkT69tVrX7Qee1efAJ6qtHdlmockqp6RPpRpGAlhd//JyjagEe/CC2fm6Ib/Ix
 oTsaAhGDwbjy8ANk0SXmRzenM6KPBFjnrhyZkd7rFK+zcJtOnJdqbL8DVF9UVEtmxq6o7GDlI
 nu1HGDAEyCfLUfcNVepPIf0unyWJsoBFFew8odEePYocxrkaXtbKe0I3u6eoeuHpG0TfdUkPd
 3FEDot55aPURyxPzYxLUStH9mjRgBNlIS21vth68ODQBKmLcb4cqslGHQkSR6lbxWd8O0jYjB
 SbTb6kOCvvDvoZYAaOU4nPdDD7zsAtxYaeF7hyNzBXMtLZAtxhR1FKiQAZmYtoOTwAq7bNEM9
 Im0N+ZJ02smPhk0yuHrn21XjIxLkN7wjtTCf99fFcj2nek34zTKuqTd4VqzA3xcmuksXd8wRb
 FKe1PD7w3lsE8zWIylE3iLH7WY4eGwlR3dJ2AyPzyEjxbLrWlxIDZrMxk8BILOH+8KuvgQbcv
 xcVDjI3+7AJYrZNKZxzkodiDYHJGHC2IxgjptflS9aJsEmPAaYS6iaHL0SLLBf+L1mCmJ+M6N
 j5MEZc5PynnY9h/jF3zX6BNTVdHV1BYoWVS5Xmfx8x7dRSN4Xw2DOot6+9QvXD8+siO3lJkM2
 aaLEHov6WM99Qeg69JUMj8eGxzKadRKLC6DHwPJqKAgoXqiCUPU2+k27HiMxcAbKUkSjDBn//
 C/R1AnM/r0NMm+yYL8QNfa0CR1Evq4uej5XSd8cSYFNmzg4+Jk3OwcDPJqPN8VD7mzEjHl6NR
 AF4pQRjwkZjr7hufbhJNZPMBxttePaaE4YgTer2JfTj6LO+LEFQ/Bx8tl26ov4F1Ix+ZV87gV
 oOx/8HeYWp1/Y511RK+9A1GTs7Hh+ixtdBld6mPeMWT6h3q1qMCpYnh9H2WrsEIZHvyGDyUTj
 RLufKFU7kydWAPlg57SrhRqrsddQpf+jJOGPhcv3lt5kxYZB5A/ubxHCBoqcPk5vbiww5nlkJ
 +YPBf+SzeXXqcYo21GJu5FiO9OpY93lA9YCnvr/DOdoWI
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 01:06, Jason A. Donenfeld wrote:
> The prandom_u32() function has been a deprecated inline wrapper around
> get_random_u32() for several releases now, and compiles down to the
> exact same code. Replace the deprecated wrapper with a direct call to
> the real function. The same also applies to get_random_int(), which is
> just a wrapper around get_random_u32(). This was done as a basic find
> and replace.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> # for sch_cake
> Acked-by: Chuck Lever <chuck.lever@oracle.com> # for nfsd
> Reviewed-by: Jan Kara <jack@suse.cz> # for ext4
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com> # for thunde=
rbolt
> Acked-by: Darrick J. Wong <djwong@kernel.org> # for xfs
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Helge Deller <deller@gmx.de> # for parisc


>   arch/parisc/kernel/process.c                   |  2 +-
>   arch/parisc/kernel/sys_parisc.c                |  4 ++--

