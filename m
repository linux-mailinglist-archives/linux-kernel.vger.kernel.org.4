Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916967A4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjAXVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjAXVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:19:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502024671F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:19:14 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id q15so14368264qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8tBkVDcR3cIjvCGSV7pCzotu/GYoRW4uPdPyTobpUU=;
        b=q/9e3e2NeK80DecsM1DxuwcETnH6bT2rG52Bz4kbxpn9ZUDkALoLB/GXpmZoTETo3u
         ZXWm/Y/fmSX/kQyrHvV20YZQMs6JQ6Sv9WnFxs0h8Vb/wNoXLt9n+bjCzB7Tu7QAtLZu
         CphXsH2+n8rm0whA1MrKA/9G7ZIUvx5OyeW2yY1CL8d+ZudMrtoaVSPZgjTh6cjycO3K
         CpQ+tnxejzvBgLmnrJjgTB2YCsA64fDR0qKx9NbotZOJrwSu4OEI+75HS8Q1t8Lip+h9
         xx5k9FZo0LIWwoLSrE8fk5zFe2yJYpbldsvt0WmLZ7b3jbz6ggh+xGtIyvyT19rsgUiS
         r3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8tBkVDcR3cIjvCGSV7pCzotu/GYoRW4uPdPyTobpUU=;
        b=WA/5FI96cAqzxsl/o6q0YEHQSMv4QrTd62SfiLA4BdPo9j1QU4jXiNNqKq55HU8m0O
         K5N14HTiKX9RhtBurEoa7hznLZytVaSfM0X9uhn+eQCyL9RBJ6ich96mgPhtuO5d30AR
         udP0xREUK3pGINsiqTUAknLfkAUEktiA3gG3mWBZM4jGb5kBIEmiHJ/EWE08n2inXifw
         nTiD4QNUPnZozwDsV3DtFFYp42OD2D+W6MIgTNhI3WXIiSe88i2FlSlJidpn1+D7Y/Op
         PoWvwSNjXJ7uBZt5OL/z2HgW3e/3Nmb6/Wgz2lLi5RXerqki6BbJTZpsVD8mvUU6Vc/b
         dI+g==
X-Gm-Message-State: AFqh2ko9S5Uv7lml9Vg+Z4avxDoDR6mJDAjopJ4YyHhUiiddlxxk2m8I
        SIrjaOAIjJdcKbeybS0pXomm+A==
X-Google-Smtp-Source: AMrXdXvVfqjmstskpsb+7KNHHK7XTOLpCh5jIf1Zf8VZzT8oMkYcJQXg4wGwRvhcYM63kTu9+3C+7Q==
X-Received: by 2002:ac8:6792:0:b0:3a8:1793:76d6 with SMTP id b18-20020ac86792000000b003a8179376d6mr40904443qtp.68.1674595153462;
        Tue, 24 Jan 2023 13:19:13 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id i7-20020ac84887000000b003b6a17e1996sm1965508qtq.83.2023.01.24.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 13:19:12 -0800 (PST)
Message-ID: <40a7e1171d7777128c0728a28a029e6f3643145a.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/2] media: meson: vdec: implement 10bit bitstream
 handling
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     neil.armstrong@linaro.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Roszak <benjamin545@gmail.com>
Date:   Tue, 24 Jan 2023 16:19:11 -0500
In-Reply-To: <95132025-8f0f-8179-40b7-8bf83458886a@linaro.org>
References: <20230124034058.3407235-1-christianshewitt@gmail.com>
         <20230124034058.3407235-2-christianshewitt@gmail.com>
         <6ff68c4bea9d48980853e9af9db1fc0bf13976ae.camel@ndufresne.ca>
         <07933226-fbab-fa78-6b96-38e365577605@linaro.org>
         <478d5a7569b7879aa3410a5b3049d745867df780.camel@ndufresne.ca>
         <95132025-8f0f-8179-40b7-8bf83458886a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Le mardi 24 janvier 2023 =C3=A0 17:51 +0100, neil.armstrong@linaro.org a =
=C3=A9crit=C2=A0:
> We hoped we could use the same modifier as DRM, but it seems this is now =
out of scope.
>=20
> Neil

Its not out of scope, its just not being worked on. There is no infra to su=
pport
an extra 64bit modifier in V4L2 atm, or to use DRM formats in general. Folk=
s
form Qualcomm or Mediatek didn't want to do it, so they worked around by ad=
ding
their strictly needed subset of compressed formats. If you don't want this,=
 then
fine, but I'm not aware of someone actively working on that today.

I was just curious if there was anything other then NV12 (something 10bit) =
on
the secondary buffer case, that was my initial question here ;-D.

Nicolas

