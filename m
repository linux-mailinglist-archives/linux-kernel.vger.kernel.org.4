Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B667F833
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjA1Nnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjA1Nne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:43:34 -0500
Received: from smtp-out-05.comm2000.it (smtp-out-05.comm2000.it [212.97.32.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC121EFE1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:43:29 -0800 (PST)
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-05.comm2000.it (Postfix) with ESMTPSA id 8DB0A826919;
        Sat, 28 Jan 2023 14:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1674913404;
        bh=da21Ge6S/e1iZ0FAsbK15MVojP6yNPTY4y19hGlX3Yo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=C564O6xp9tl00Rw+05765kuXXtUfXGT5QTbLV2CRd9xAIljvpGKoqdqIi+krcACsv
         Udg7N7tKWqyuFL9fEeuNGnEqbhNNXb+mASW7gN0BYrEIgjBDJIssHpR73PzZ/BzlQP
         SyE+V37QrVif7uyp56gvkFsSBTZFiy8XRnR90U3GtXWfvHSwXzNxGv7hJpw3nt2wCG
         obIyWfBTri6DPVk3IYFaQApvmH493H2MAg1nqvJARhjYz+CaaDPrd4wpnB++3w5aBi
         12OAn5kzGklD01clVE79fXxVJktN7lVWmAmXlCYbs6YwocHmTmb8tUw+F2OCbEEyd6
         S3escmT3O6Hug==
Date:   Sat, 28 Jan 2023 14:43:23 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Mark Brown <broonie@kernel.org>
CC:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: fixed-regulator with enable from another regulator
User-Agent: K-9 Mail for Android
In-Reply-To: <Y9UgENl4KZT5e/ot@sirena.org.uk>
References: <Y9RDGnZLg6wGJWwn@francesco-nb.int.toradex.com> <Y9UgENl4KZT5e/ot@sirena.org.uk>
Message-ID: <C1E878D9-2C30-454A-AC4D-DB2996313544@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28 gennaio 2023 14:16:00 CET, Mark Brown <broonie@kernel=2Eorg> ha scrit=
to:
>On Fri, Jan 27, 2023 at 10:33:14PM +0100, Francesco Dolcini wrote:
>
>> I am trying to figure out if it is possible with the current
>> regulator-fixed or with any other solution already implemented in Linux
>> to have a regulator enabled from another one=2E
>
>Not really=2E  You can model the regulators as sharing the same
>enable if there's a GPIO enable for the parent regulator,
>otherwise it'd need some framework work=2E

Thanks, I'll propose a patch if needed=2E

>> I am still not 100% sure if describing this specific hardware connectio=
n
>> would be required on my system, maybe I can just ignore all of that=2E
>
>It seems like a fairly strange hardware design TBH=2E

Just to shred some light on this weird request, I am not the one who did t=
he design, but there is a reason=2E

There is one device that requires 3 different voltages, one of those come =
from a dedicated output of a PMIC, the other 2 from dedicated LDOs=2E

Having the enable of the 2 LDO on the PMIC output allows to control the po=
wer of the device without additional GPIOs usage (that were not available, =
for instance, while the PMIC can enable/disable the output from I2C)=2E

(not that is relevant for this discussion, but this is of course fine for =
the power sequencing of this specific device)=2E

Francesco


Hello Mark,
