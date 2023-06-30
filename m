Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CC7444CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF3WZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjF3WZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:25:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880D3C01
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:25:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so2630727a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163913; x=1690755913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsyn2aeFJmWCIt+CIIRNtExvH43vvahqiLuTVZJsDz0=;
        b=WWvhY0jgAqjLtu11/Hqy7BmtXmBTmEl66GvOGDMGQNIfqqSNEf57Pwnj+jpUHpBL5V
         aNovAtkekekGftDop82thROpVzM81JpyYB+GxLe/4sclNR5s8ZFoZRfCg1Ux+3vxR6ZE
         nL0pr6ALMIKrJVwDrtJ9c2DOtOJ1u5nVHgwv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163913; x=1690755913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsyn2aeFJmWCIt+CIIRNtExvH43vvahqiLuTVZJsDz0=;
        b=Zafktc2dOV1+37QIHIedNK8UbxtO7R2CDCKtoIz9KXaBvtdfseHjvPUTPKyInVvABY
         KHYuwJz0WIhqgLyLpg9p9sdXepW5gx1dn7SdzW/U5sow67rSShAJxWo5UWnEPFs2AY5l
         Cub+8HnlXfRd+nqO6z5NtVYiIMyr3yPHxkqHy92ksnm1JSKFlWOrZn0SgOaQUeMComC+
         FKtZ2R1F5ZWAoOuU4fLsv6GmStWktxajPOI7TV9OnGz+74CS9PhK4Fs2hIW7dXN8POnI
         6hBgmqv75xiNty0Y4iO0/6e7Ub4OWYcsBZ4zwEgXb/uT0FwN+dJ+RpnbZUb5yxp17Nhd
         7uQw==
X-Gm-Message-State: ABy/qLZOwwpEIvWKqc/2YwgIZ8ahHUIUUU9TiUmtmMG+Kf52z7V5NAx2
        kmwq5cVGHCM09LBQ9vnb5nLNs7WhU6s2XWs1NkjFiw==
X-Google-Smtp-Source: APBJJlF7J3Zd3XX47r/Shbc3V8l4M3hF7ISKyMEcI8vzXXvVw6fchmy8YKydyBk0nCXQf8HdcJQEkA==
X-Received: by 2002:a50:fa90:0:b0:51d:893c:60c3 with SMTP id w16-20020a50fa90000000b0051d893c60c3mr2662143edr.9.1688163913607;
        Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402135300b0051bee1eadccsm7170870edw.31.2023.06.30.15.25.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so1139a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
X-Received: by 2002:a50:c242:0:b0:506:90c4:b63b with SMTP id
 t2-20020a50c242000000b0050690c4b63bmr22665edf.4.1688163912665; Fri, 30 Jun
 2023 15:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CAGPPCLDybSapT7ncUfskHw+ykqcUzbWiayM0YtAW_2RDbB1Qzw@mail.gmail.com>
In-Reply-To: <CAGPPCLDybSapT7ncUfskHw+ykqcUzbWiayM0YtAW_2RDbB1Qzw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:25:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XyZ9Zsc3zLcN3iSGRaBLQsQA36MNgXwcW7vj_+gBRkSg@mail.gmail.com>
Message-ID: <CAD=FV=XyZ9Zsc3zLcN3iSGRaBLQsQA36MNgXwcW7vj_+gBRkSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg
 for hci_remove_adv_monitor()
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 3:20=E2=80=AFPM Manish Mandlik <mmandlik@google.com=
> wrote:
>
> Hi Douglas,
>
>
>
> On Fri, Jun 30, 2023 at 3:10=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
>>
>> KASAN reports that there's a use-after-free in
>> hci_remove_adv_monitor(). Trawling through the disassembly, you can
>> see that the complaint is from the access in bt_dev_dbg() under the
>> HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
>> msft_remove_monitor() can end up freeing the monitor
>> structure. Specifically:
>>   hci_remove_adv_monitor() ->
>>   msft_remove_monitor() ->
>>   msft_remove_monitor_sync() ->
>>   msft_le_cancel_monitor_advertisement_cb() ->
>>   hci_free_adv_monitor()
>>
>> Moving the printout to before the memory is freed.
>>
>> Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Move the print, don't stash handle in a local.
>>
>>  net/bluetooth/hci_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 48917c68358d..7e2ecf8a55d8 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1980,9 +1980,9 @@ static int hci_remove_adv_monitor(struct hci_dev *=
hdev,
>>                 goto free_monitor;
>>
>>         case HCI_ADV_MONITOR_EXT_MSFT:
>> -               status =3D msft_remove_monitor(hdev, monitor);
>>                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
>>                            hdev->name, monitor->handle, status);
>> +               status =3D msft_remove_monitor(hdev, monitor);
>
> Thanks for catching this. But that log also prints the value of "status".=
 So, moving "status =3D msft_remove_monitor(hdev, monitor);" after the prin=
t will print an incorrect value of "status".

Ah crud, you're right. :(

OK, I'll send v3 which will be back to v1 for the first patch.

-Doug
