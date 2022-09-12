Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508DE5B5F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiILRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiILRaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:30:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EE19030;
        Mon, 12 Sep 2022 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663003786;
        bh=le7Hd+CVZKvyI8cRoUEmz4/qdEQPFqmPQE68nCfLxLM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZzZRaZD0OOQhPNBE1Kx31W1LmPDgyJY7AekTLtg7jMdjMx47K7QU8MlBXyGQfdVB9
         DjgRt3wyvFHVQU0oCfLsa+d656MzSQWhFhTWUuLduV5d4ldxTt74DnXq1kpQ1Yjj0v
         Vt2MPj/r79HOXzDl8uK/YTLfuzOrX8pb+p4RhGCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1pMAyp2PIP-00tQ2Q; Mon, 12
 Sep 2022 19:29:46 +0200
Subject: Re: [PATCH 3/5] ACPI: battery: Allow battery hooks to be registered
 multiple times.
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-4-W_Armin@gmx.de>
 <wY3UHtenNt5tmQSMtoDLmzNxvJ7B56SLwlhguYfg6rqC71dDDCYypvSqvS0SUhRJwsel8wBEy3yeS8rDlJCOii24Llo0XKU34IcSn5WNwg8=@protonmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <155062a9-8d1a-e771-1bee-35580b1b2b73@gmx.de>
Date:   Mon, 12 Sep 2022 19:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <wY3UHtenNt5tmQSMtoDLmzNxvJ7B56SLwlhguYfg6rqC71dDDCYypvSqvS0SUhRJwsel8wBEy3yeS8rDlJCOii24Llo0XKU34IcSn5WNwg8=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:bdj8FMZD7tMIwPC/ksvUpRNyQqCwV+ldwI02o5ILod4hUEQk+h8
 DXozwhFh1pceb3/GkW+EliRwkhZ0dQoHDQHdzvX5YOKNwazFsL97Sj5DXPs54boLWtqChUR
 35Yd7ufis5GjcM675xncg1kyMATEDolQWAKXusvcGDnRoop6YTEm1Ev/mFIXco7Ng0MKauI
 AUqhW/FCOMSsH1FmddhCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hEjY63qmLik=:+zINZNHgvC4OyF4g8553NF
 6rTG7ChLVVn67f8lRi9ILSeSWERRAUXEyr8sPkv+/bnyJ9C3a8bwhLWvX/JqLg0pjxHhfe9MS
 Qhxk+8/AvrnxKyc912+JsyAHSza7w/lKwA2d+MeTuwtTpKCLQ/zpHd0XhJ5jiqsNt4gteEp2Z
 aa+/q5pAxvpTy+S/wQ24bcAzQ80vJ6Pju5iMJKX+8SW5RF2ReXZJ7Ve/LpG35iWZDN/CWBluF
 oukfm4q338k7FVXB5UYPb0xFgwDDmIqRfeo8aK+ewS0I7/O60yYDdo4XwArrmR08xxHiqxZnM
 SnUxHx6ojHMLQ04NO5srMwAQH+B+SBKxZhDpknTUUd96tIUz0VB3CTMa9cbtr5HB0jUXnSqNC
 D5kgc1oxA0TxKyiYMC3RSBS52Nv7vmL4hQuuRCoEukBFm0yZ3PyiaLfXZMn/wlmQ1NjE36l/J
 ux/JrFUPI6YNiDXUOGb4jdjw4zig3VJ+OxlEcR26lTmMrw3Bs1ah1lNsNg+P22jIXOLWH9u2G
 roJ99gw5caI14HTTrJTjtUG0GsBWzT6F1L/lwUSUiWKj5+3l9qGmjpG/ljFpeDeD0uRJYa4oB
 J3MVs+2VHfSKTkbs025lNhgXcw2qpBBPyOL7DrD1vMTiTKA/KEKNWwWPMIV7xhw6XSNLeUOLJ
 4PJGc9TpMHKNp+WtklOwtX51y4UY9T/V8wqyQzPJwKsbJyO7u1Z8+KARhtctyAJz4r4Li+wyU
 92xgYWySgWMrTT8hfs0K1w8CXJp5Hyfid/jcf7qRX2yTHjp/shplRG6u8xaosUjt3VF8ozM2D
 +MvtMXvBBD9t5tLK9F7gXMN5i2OYjRh5U7v/njWob5MqGGSi9d2u8ptD3GkPgORGQHPjVciWg
 Ih2MkiWlF8xvpYmn2z2WHuTQZyQRID2e8cBC5EnNe6Ezamp+hhmv4WgIR5xSeNZojoY4WwQh3
 TYO9+mjFM5TfBqKpOxSr3AuWrIps7T6xV0VXKqztij1P/YAfsYRjBbTY6v3qtn/YAg6pshm44
 AC2ycw5r/W+7hALgUTSUERh+aqUEwCVuybvV8PVWsPl6r9p9OzkZdPxeMHRzA1s3Lgz6k32IZ
 Iikwvs2fox6nwHuxv8AGKJ25yIzvBepbauEbo525tUjZTf++8KBd2HkQ4mVIhkvfHkRP+ktGC
 TaFn5Y22rsLQtTiHL482EFjM+2
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.09.22 um 18:42 schrieb Barnab=C3=A1s P=C5=91cze:

> Hi
>
> 2022. szeptember 12., h=C3=A9tf=C5=91 14:53 keltez=C3=A9ssel, Armin Wolf=
 =C3=ADrta:
>
>> Registering multiple instances of a battery hook is beneficial
>> for drivers which can be instantiated multiple times. Until now,
>> this would mean that such a driver would have to implement some
>> logic to manage battery hooks.
>>
>> Extend the battery hook handling instead.
> I think this is already possible by embedding the acpi_battery_hook
> object inside the driver's device specific data object, no?
>
> Regards,
> Barnab=C3=A1s P=C5=91cze
>
>
Yes, it indeed is. However afaik it is not possible to pass instance-speci=
fic
data to such an embedded battery hook. It could be possible by passing the
battery hook as an argument to add_battery()/remove_battery() and using co=
ntainer_of(),
but in my opinion this would be too much of a quick hack.

>> [...]
