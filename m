Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782773EB30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFZTZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjFZTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:25:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177A1700;
        Mon, 26 Jun 2023 12:25:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b5c2433134so30032651fa.0;
        Mon, 26 Jun 2023 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687807524; x=1690399524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NFypNUympay54cWESrUztMRbmrTa5aoLaDv8wRaHyk=;
        b=LnHIUwEIcP2pbXYaPoaAF/4xSheQVBu061Iu2+/UOzv5F5HeQk9tVn3M+KeSXKcgn5
         bH/gjVAeB+ISb5Dt9HYF773Wv3RyiXBXEBjjkF1NKcUtjA0Z9QQ/j+gDOWBAFH3r3ute
         wNyyiLmezGAH2Q/bfZJ8rkWwBAySe8cNp4MB7J9fqJtmoqLbXIljLZNVkj0hLV9TeJhZ
         My50++zYAkbgOEEZ9OEZgjdVFaCFPhzmL0KiXcAYe4/F4ythLq8wWNqJgxb0dbZHKVzU
         0u0uibLstNJ1ggzsHso8yXTR3nPdHQVK/aPeSDHY5WGYvUIqDRA/N3o6MM70q0et/T6h
         4bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687807524; x=1690399524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NFypNUympay54cWESrUztMRbmrTa5aoLaDv8wRaHyk=;
        b=d74MmAwB+fFC8uKLLyjOwTF0t5C+5vwo8Z/IboTRF8QQYfRI+VgKR/rZYXxDLiwysS
         3yvF6sBH/ozi2TGdaA5gXm2mvomQz5j8m13y6VjnJKg/CZMmAUaBLwtlbFUzyjU0/SEY
         McSQImaZwQR6YtITZc91sfq75e4UViISe9JSknL3lyXpGOjsQas4R8RZU73OVRaj6hG2
         GwKaYuh9sohn/6fql74mmqL6rBi+uh048Ns84JSy7rlTYOtsF1T4rob+QCLBj1cVg7Ya
         eIhtfZDDvTr+qLw6eky0s0ayuTzzypbh4zYjigKZE1DerYbS5saPc2yyoKeG2bzQU1qx
         XpqA==
X-Gm-Message-State: AC+VfDx2HcO+tcyG1vbI5HyszLijL05dEDF8HftTdRUwmtE3ZSLYmzFb
        cJt2OAgxvDjbiW1KvdO15P7wywyynquFhXhgHwY=
X-Google-Smtp-Source: ACHHUZ52YLNCzMs7G5WhmajLVFQEbSpIPEzBT2uH/WajntZtI7mXMfpPIwlie0L7t6pFa9D+R6aydxShD/0DtMiCZk0=
X-Received: by 2002:a2e:a268:0:b0:2b4:7763:c1fb with SMTP id
 k8-20020a2ea268000000b002b47763c1fbmr9829487ljm.13.1687807524076; Mon, 26 Jun
 2023 12:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <259e755c.4eaad.188f817a0f3.Coremail.lxybhu@buaa.edu.cn>
In-Reply-To: <259e755c.4eaad.188f817a0f3.Coremail.lxybhu@buaa.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jun 2023 12:25:12 -0700
Message-ID: <CABBYNZJtGo2SSRREH9jpAKM8UoEUNgK9uzyPuzqDdks_KBoDdw@mail.gmail.com>
Subject: Re: [BUG]Bluetooth: HCI_Command_Status: possible semantic bug when
 Num_HCI_Command_Packets set to zero
To:     =?UTF-8?B?5YiY5paw5a6H?= <lxybhu@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 26, 2023 at 7:25=E2=80=AFAM =E5=88=98=E6=96=B0=E5=AE=87 <lxybhu=
@buaa.edu.cn> wrote:
>
> Hello,
>
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in=
 Linux 5.18:
>
> During the connection process, the host server needs to receive the HCI_C=
ommand_Status packet from the hardware controller. In normal cases, the Num=
_HCI_Command_Packets field of this packet is not zero, and the host server =
can normally handle this packet. However, in our testing, when the Num_HCI_=
Command_Packets field is set to zero, the Bluetooth functionality is totall=
y stopped until it is manually reopened.
>
> In the Bluetooth Core Specification 5.4, the section 7.7.15 "Command Stat=
us event" says that:
>
> "The Num_HCI_Command_Packets event parameter allows the Controller to ind=
icate the number of HCI command packets the Host can send to the Controller=
. If the Controller requires the Host to stop sending commands, the Num_HCI=
_Command_Packets event parameter will be set to zero."
>
> This section does not mean that the Bluetooth functionality needs to be t=
otally stopped when Num_HCI_Command_Packets is zero. Maybe in this case, th=
e Bluetooth functionality could be still available, but the host server cou=
ld reject any packet until Num_HCI_Command_Packets is not zero.

Well it says, If the Controller requires the Host to stop sending
commands, so if your tool is sending 0 then it is requesting he host
to stop sending more commands, if you want it to continue just send
another Num_HCI_Command_Packets, or are you saying some other
functionality that doesn't require sending commands shall still work?

> We are not sure whether this is a semantic bug or implementation feature =
in the Linux kernel. Any feedback would be appreciated, thanks!
>
>
> Best wishes,
> Xin-Yu Liu



--=20
Luiz Augusto von Dentz
