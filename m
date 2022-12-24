Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100265591E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLXISL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiLXISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:18:06 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA5BC31;
        Sat, 24 Dec 2022 00:18:04 -0800 (PST)
Received: from [192.168.1.11] (dynamic-078-054-161-246.78.54.pool.telefonica.de [78.54.161.246])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C1A3460027FCB;
        Sat, 24 Dec 2022 09:18:00 +0100 (CET)
Message-ID: <3fb69c7f-0e75-8dc5-f26d-89d49d200f69@molgen.mpg.de>
Date:   Sat, 24 Dec 2022 09:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] Bluetooth: btusb: Work around for spotty SCO quality
To:     Hilda Wu <hildawu@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        apusaka@chromium.org, yinghsu@chromium.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
References: <20221223085742.2482-1-hildawu@realtek.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221223085742.2482-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hilda,


Thank you for the patch. For the subject the *for* is superfluous:

Work around spotty SCO quality

Am 23.12.22 um 09:57 schrieb hildawu@realtek.com:
> From: Hilda Wu <hildawu@realtek.com>
> 
> When streaming HFP, every few minutes a brief pause in audio can be
> heard on some platforms with Realtek Bluetooth. Linux based products
> may be encountered, but because of the different implementation of
> upper-level SCO services, the situation would not necessarily impact
> customer experience. But when the issue occurs, the system will see
> the SCO packet for unknown connection handle messages.
> 
> Note: This issue affects (e)SCO only, does not affect ACLs.
> The duplicate data affected the invalid connection handle only
> occurs in Realtek BT.
> This is to filter out the duplicate packet for avoiding influence.
> 
> The btmon trace give a better idea of what we're filtering.

give*s*

> The following excerpts are part of SCO packets in the HCI log:
> 
>> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23327 [hci0] 132.343418
>          8c a3 55 4f 8a d5 56 e9 35 56 37 8d 55 87 53 55  ..UO..V.5V7.U.SU
>          59 66 d5 57 1d b5 54 00 01 08 ad 00 00 e0 10 00  Yf.W..T.........
>          00 00 85 c6 d5 60 e9 b5 52 94 6d 54 e4 9b 55 b1  .....`..R.mT..U.
>          b6 d5 62 91 b5 57 84 6d 56 e4 5b 55 75 c6 d5 51  ..b..W.mV.[Uu..Q
>          2d b5 53 9a 6d 54 a5 1b                          -.S.mT..
> < SCO Data TX: Handle 11 flags 0x00 dlen 72      #23328 [hci0] 132.343600
>          01 c8 ad 00 00 aa db ba aa a9 72 b4 d9 5d af 14  ..........r..]..
>          53 0c 75 b0 a6 f3 8a 51 b3 54 17 b1 a6 d5 62 c5  S.u....Q.T....b.
>          d5 6b 35 29 8d c5 1c 56 4c 24 96 9b 8d b5 d7 1a  .k5)...VL$......
>          b2 8d bc da 3b 8c 46 ae 1d 4d a4 04 01 f8 ad 00  ....;.F..M......
>          00 3d ec bb a9 98 8b 28                          .=.....(
>> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23329 [hci0] 132.353419
>          55 55 c6 d5 62 29 b5 57 b2 6d 54 00 01 38 ad 00  UU..b).W.mT..8..
>          00 e0 10 00 00 00 0b 00 d5 62 55 c6 57 b2 29 b5  .........bU.W.).
>          00 01 6d 54 00 00 38 ad 00 00 e0 10 00 00 00 92  ..mT..8.........
>          36 d5 5a ed b5 58 6c 6d 55 b3 1b 55 6b 26 d5 52  6.Z..XlmU..Uk&.R
>          d1 b5 54 23 6d 56 82 db                          ..T#mV..
> < SCO Data TX: Handle 11 flags 0x00 dlen 72      #23330 [hci0] 132.353581
>          6d 5b be db 89 34 66 e9 fa 99 a6 6e e5 6d 9f 1a  m[...4f....n.m..
>          1c 57 d2 66 92 63 98 99 a9 3b 8a 6c 3e 5b 5a 34  .W.f.c...;.l>[Z4
>          a4 96 e2 21 21 8c f8 88 0f 3d e0 52 48 85 18 00  ...!!....=.RH...
>          01 08 ad 00 00 0c eb ba a9 a8 28 ca 9a d0 3c 33  ..........(...<3
>          45 4a f9 90 fb ca 4b 39                          EJ....K9
>> SCO Data RX: Handle 2901 flags 0x0a dlen 54    #23331 [hci0] 132.373416
>          d5 48 a9 b5 56 aa 6d 56 d2 db 55 75 36 d5 56 2d  .H..V.mV..Uu6.V-
>          b5 57 5b 6d 54 00 0b 00 48 01 c8 ad 00 00 e0 10  .W[mT...H.......
>          00 00 00 5e c6 d5 56 e1 b5 56 43 6d 55 ca db 55  ...^..V..VCmU..U
>          7d c6 d5 5b 31 b5
> 
> We handle is HCI SCO Data RX packets.
> The packet 23327 was a normal HCI SCO Data RX packet.
> The packet 23329 was the abnormal HCI SCO Data RX packet.
> The packet 23331 was the invalid connection handle affected by the
> packet 23329 abnormal HCI SCO Data RX packet.
> 
> So we expect to filter is the packet 23329 SCO data RX packet case.
> As you can see the packet 23329, packet's connection handle (0x0B 00/11)
> and length (0x48/72) is normal.
> This btmon trace is SCO packets in USB alternate setting 3, payload
> length is 72 bytes that is consist of three SCO data packets.
> After our investigation, we found that the anomaly is due to the
> intermediate composition data.
> There is duplicate data in the intermediate composition data, but it
> affects packets combination. The system parses the next packet of the
> connection handle mistake, so the system see unknown connection
> handle messages.
> 
> This commit can estimate and find out its abnormal rule to filter the
> duplicate packet out for avoiding influence.
> Check franments and filtering out the abnormal packet and then it will

fragments

> not affect the system parsing of the conenction handle subsequent.

connection

> This commit can filter out the invalid connection handle, avoid the

handle, and avoid …

> spotty SCO quality.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>

[…]


Kind regards,

Paul
