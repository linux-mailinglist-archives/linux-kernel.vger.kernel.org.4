Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD567DC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjA0DAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjA0C76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:59:58 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8C2F7B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:59:52 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m26so3061850qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=6BGsahl6zZBDe4ZJTgBdJgbxf/BMvsg6NvL9K8ucfLA=;
        b=WpHX4u0NKxli2UxIT7RC87/fYz+9yv0K2+IoimtNrLKRf87Gi0xnfLFI5UPYELE4Ma
         5mJyj9CjsyQ9BXX2dJQq3UJ7LB2r71gbyRj+nXcjX1ShAcgUk2EbUNnmjZvg867foFBg
         eWu/D7LG/6/lmksAV1zw6OyRhGMwk+XyxiL6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BGsahl6zZBDe4ZJTgBdJgbxf/BMvsg6NvL9K8ucfLA=;
        b=tgIVh9uP5rCEXky5QGt3oUry9fga1A8nsceJtHY7qnM3ADboF1B9KL/B+XgNHQhr3X
         JEC/9pGuhRxWRls32i5Y45P8o2NmE4eyXSh3/igd3JKbPJZLikl6AdjBFe8HO8hUR7zZ
         c9ag5gtYD3tbh2yLl6XzXHYpRBwH2WehCXht78ceb3fjxIBY7iWK2LeYNIkPNi4XaW9H
         dazDtQgipOKfreobE4yxVmufsLpKDv/7XInes/J8T/N8NmvcUCPNJltMRgRDNERX4DR8
         aSYMLBso/tn8b09wltnZa73arGizURoU0YWzrb9xdxOetD7TcQZ1p+so0x7u2IK5B/Y/
         Y1dQ==
X-Gm-Message-State: AO0yUKXRRxmLTjqDikC5ggIpe5grAiQwdSsZYh6SzItBXKX/n7ERuFWq
        7zuw0ZmciKqByzXkBmzEVZ21+lqJhhPbR81Mly5koOqL8TLRNV0wZFNsskM217D3S3UAbnXhUpf
        w6B0eyJdGWg72YvuPxNHUX56lNyDGyGaSzb2HD12eLBe4xgWWqhgFBfNicYKUEqBIJb9UxAkuW7
        OmuicWtQqVN34=
X-Google-Smtp-Source: AK7set9iiF0M9KTCJRRB5kot2CQ0Jr+FTEyBDwuJEGMMPsM8bn6J48LYD0lD9i1e5RgKOs838oaNqw==
X-Received: by 2002:ac8:5cc6:0:b0:3b6:414f:c2ba with SMTP id s6-20020ac85cc6000000b003b6414fc2bamr15080524qta.38.1674788391235;
        Thu, 26 Jan 2023 18:59:51 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i1-20020a37b801000000b00702d1c6e7bbsm2014532qkf.130.2023.01.26.18.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 18:59:50 -0800 (PST)
Subject: Re: [PATCH v2 10/14] spi: bcm63xx-hsspi: Add prepend mode support
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-11-william.zhang@broadcom.com>
 <CAOiHx=nfKnXwhYKfuQP4KKT-URfAg4jz-8QOh8EP3L=mvc=pUQ@mail.gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <dfba682c-c855-df9c-4081-cd65ada5f61b@broadcom.com>
Date:   Thu, 26 Jan 2023 18:59:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nfKnXwhYKfuQP4KKT-URfAg4jz-8QOh8EP3L=mvc=pUQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000028c9bb05f3360f39"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000028c9bb05f3360f39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/26/2023 07:15 AM, Jonas Gorski wrote:
>> +static int bcm63xx_hsspi_wait_cmd(struct bcm63xx_hsspi *bs)
>> +{
>> +       unsigned long limit;
>> +       u32 reg = 0;
>> +       int rc = 0;
> 
> If the only possible return values are 0 and 1, maybe this should be a bool?
> 
Well it is possible we may want to return to some specific error code so 
I would prefer to keep it as is.

>> +
>> +       if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
>> +               if (wait_for_completion_timeout(&bs->done, HZ) == 0)
>> +                       rc = 1;
>> +       } else {
>> +               /* polling mode checks for status busy bit */
>> +               limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
>> +
>> +               while (!time_after(jiffies, limit)) {
>> +                       reg = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
>> +                       if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
>> +                               cpu_relax();
>> +                       else
>> +                               break;
>> +               }
>> +               if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
>> +                       rc = 1;
>> +       }
>> +
>> +       if (rc)
>> +               dev_err(&bs->pdev->dev, "transfer timed out!\n");
>> +
>> +       return rc;
>> +}
>> +
>> +static bool bcm63xx_check_msg_prependable(struct spi_master *master,
>> +                                         struct spi_message *msg,
>> +                                         struct spi_transfer *t_prepend)
> 
> This function does more than just checking, so I think a more
> appropriate name would be something like
> 
> bcm63xx_prepare_prepend_transfer()
> 
That's reasonable. The function kind of evolved from the checking only.

>> +{
>> +
>> +       struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
>> +       bool prepend = false, tx_only = false;
>> +       struct spi_transfer *t;
>> +
>> +       /* If it is forced cs dummy workaround mode, no need to prepend message */
>> +       if (bs->xfer_mode == HSSPI_XFER_MODE_DUMMYCS)
>> +               return false;
> 
> That's a weird point for that, why not just move this to the caller
> and check it before calling the function.
> 
True following your above function name change suggestion.

>> +
>> +       /*
>> +        * Multiple transfers within a message may be combined into one transfer
>> +        * to the controller using its prepend feature. A SPI message is prependable
>> +        * only if the following are all true:
>> +        *   1. One or more half duplex write transfer in single bit mode
>> +        *   2. Optional full duplex read/write at the end
>> +        *   3. No delay and cs_change between transfers
>> +        */
>> +       bs->prepend_cnt = 0;
>> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
>> +               if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) {
>> +                       dev_warn(&bs->pdev->dev,
>> +                                "Delay or cs change not supported in prepend mode!\n");
> 
> I don't think warn is the right level. If we are on XFER_MODE_AUTO,
> this should be _dbg, since we will just fall back to the dummy cs
> mode, if we are on XFER_MODE_PREPEND, this should be dev_err, since we
> cannot do the message.
> 
I was relying on this to see the message when we fall back. But 
certainly I can fine tune the message level as you suggested

> cs->change is technically supported when all that's requested is a
> between transfer cs toggle (t->cs_change is true, t->cs_off is false
> and next transfer's cs_off is also false), which automatically happens
> after the transfer. Not sure if it is worth the effort implementing
> that though.
> 
If this cs toggling is between the transfers that we are merging here, 
then no as the cs will be always active during merged transfer in 
prepend mode.

>> +                       break;
>> +               }
>> +
>> +               tx_only = false;
>> +               if (t->tx_buf && !t->rx_buf) {
>> +                       tx_only = true;
>> +                       if (bs->prepend_cnt + t->len >
>> +                               (HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
>> +                               dev_warn(&bs->pdev->dev,
>> +                                        "exceed max buf len, abort prepending transfers!\n");
>> +                               break;
> 
> why not just return false here directly? And everywhere else where you
> decided that you cannot use prepend.
> Sure I can eliminate the prepend variable and return directly

>> +                       }
>> +
>> +                       if (t->tx_nbits > SPI_NBITS_SINGLE &&
>> +                               !list_is_last(&t->transfer_list, &msg->transfers)) {
>> +                               dev_warn(&bs->pdev->dev,
>> +                                        "multi-bit prepend buf not supported!\n");
>> +                               break;
>> +                       }
>> +
>> +                       if (t->tx_nbits == SPI_NBITS_SINGLE) {
>> +                               memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf, t->len);
>> +                               bs->prepend_cnt += t->len;
>> +                       }
>> +               } else {
>> +                       if (!list_is_last(&t->transfer_list, &msg->transfers)) {
>> +                               dev_warn(&bs->pdev->dev,
>> +                                        "rx/tx_rx transfer not supported when it is not last one!\n");
> 
> This is only an issue if doing multi-bit RX/TX; for single bit you can
> just upgrade the whole transfer/message to duplex, you just need to
> pick the read bytes then from the right offsets.
> 
I am not sure if this will work all the case.  Considering two transfers 
rx 3 bytes then tx 3 bytes in the message(not sure if there is any 
device requires this kind of message but just for discussion 
purpose...),  if I upgrade it to duplex message,  the controller will 
transfer and receive 6 bytes data in duplex mode where prepend count is 
zero.  So the extra 3 tx bytes while receiving the first 3 bytes may 
disturb the device as they are not expected.  It may or may not work. I 
would rather just fallback to dummy cs workaround instead of causing 
potentially issue.

>> +                               break;
>> +                       }
>> +               }
>> +
>> +               if (list_is_last(&t->transfer_list, &msg->transfers)) {
>> +                       memcpy(t_prepend, t, sizeof(struct spi_transfer));
>> +
>> +                       if (tx_only && t->tx_nbits == SPI_NBITS_SINGLE) {
>> +                               /*
>> +                                * if the last one is also a single bit tx only transfer, merge
>> +                                * all of them into one single tx transfer
>> +                                */
>> +                               t_prepend->len = bs->prepend_cnt;
>> +                               t_prepend->tx_buf = bs->prepend_buf;
>> +                               bs->prepend_cnt = 0;
>> +                       } else {
>> +                               /*
>> +                                * if the last one is not a tx only transfer or dual tx xfer, all
>> +                                * the previous transfers are sent through prepend bytes and
>> +                                * make sure it does not exceed the max prepend len
>> +                                */
>> +                               if (bs->prepend_cnt > HSSPI_MAX_PREPEND_LEN) {
>> +                                       dev_warn(&bs->pdev->dev,
>> +                                               "exceed max prepend len, abort prepending transfers!\n");
>> +                                       break;
> 
> Likewise, you can merge any amount or rx/tx/rxtx single bit transfers
> together as a duplex transfer with prepend len set to 0 (so
> technically not a prepend anymore ;-)
Same here.  Let's just fallback to dummy cs workaround mode.

> 
>> +                               }
>> +                       }
>> +                       prepend = true;
>> +               }
>> +       }
>> +
>> +       return prepend;
> 
> and then if you already returned false if you cannot do prepend, you
> just need to return true here and don't need the prepend variable.
> 
>> +}
>> +
>>


>>   static int bcm63xx_hsspi_setup(struct spi_device *spi)
>> @@ -344,9 +578,23 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>>          int status = -EINVAL;
>>          int dummy_cs;
>>          bool restore_polarity = true;
>> +       struct spi_transfer t_prepend;
>>
>>          mutex_lock(&bs->msg_mutex);
>> -       /* This controller does not support keeping CS active during idle.
>> +       if (bcm63xx_check_msg_prependable(master, msg, &t_prepend)) {
>> +               status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
>> +               msg->actual_length += (t_prepend.len + bs->prepend_cnt);
> 
> why +=? shouldn't this be the only place in this case where this is set?
> 
probably copy/paste error from the dummy cs loop.  Will fix.

>> +               goto msg_done;
>> +       }
>> +
>> +       if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
>> +               dev_warn(&bs->pdev->dev,
>> +                       "User set prepend mode but msg not prependable! Fail the xfer!\n");
> 
> If we are failing, this should be a dev_err, not a dev_warn
> 
Will fix.

>> +               goto msg_done;
>> +       }
> 
> I think from a readability standpoint it would be better to move the
> cs_workaround parts into their own function, and have this as
> 
>      bool prependable = false;
> 
>      if (bs->xfer_mode != HSSPI_XFER_MODE_DUMMYCS)
>          prependable = bcm63xx_prepare_prepend_transfer(...);
> 
>      if (prependable) {
>        status = bcm63xx_hsspi_do_prepend_txrx(...);
>        msg->actual_legth += ...;
>      } else {
>        if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
>             /* we may not use dummy cs */
>             dev_err(...);
>             status = -EINVAL;
>        } else {
>             status = bcm63xx_hsspi_do_dummy_cs_txrx(...);
>        }
>      }
> 
> with (bcm63xx_hsspi_do_dummy_cs_txrx being the proposed function name).
> 
Sound good to me.

>> +
>> +       /*
>> +        * This controller does not support keeping CS active during idle.
>>           * To work around this, we use the following ugly hack:
>>           *
>>           * a. Invert the target chip select's polarity so it will be active.
>> @@ -364,6 +612,17 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>>          bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
>>
>>          list_for_each_entry(t, &msg->transfers, transfer_list) {
>> +               /*
>> +                * We are here because one of reasons below:
>> +                * a. Message is not prependable and in default auto xfer mode. This mean
>> +                *    we fallback to dummy cs mode at maximum 25MHz safe clock rate.
>> +                * b. User set to use the dummy cs mode.
>> +                */
>> +               if (bs->xfer_mode == HSSPI_XFER_MODE_AUTO) {
>> +                       if (t->speed_hz > HSSPI_MAX_SYNC_CLOCK)
>> +                               t->speed_hz = HSSPI_MAX_SYNC_CLOCK;
> 
> OTOH, this may be a point where a dev_warn (once?) might be a good
> idea, since the device may depend on a certain speed to avoid buffer
> overruns (e.g. audio streams - not sure if that exists), so a warning
> that the transfer speed was reduced will help identifying the source.
> 
> 
That make sense. Should add a warning here.

> 
>> +               }
>> +
>>                  status = bcm63xx_hsspi_do_txrx(spi, t);
>>                  if (status)
>>                          break;

--00000000000028c9bb05f3360f39
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDDG6HZcbcVdEvVYk4TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTMxNDVaFw0yNTA5MTAxMTMxNDVaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVdpbGxpYW0gWmhhbmcxKTAnBgkqhkiG9w0B
CQEWGndpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAyKF+RmY29Wvfmfe3L8J4rZNmBIvRmrWKI5td5L0vlpPMCEzUkVhBdL2N9cDP0rPScvWL
CX/9cI1a2BUy/6/ZT5j9PhcUn6A3kwKFGukLY2itfKaDrP3ANVJGhBXPVJ6sx55GF41PkiL2EMnY
7LJGNpl9WHYrw8VqtRediPyXq8M6ZWGPZWxygsE6y1pOkEk9qLpvXTb2Epxk2JWcQFZQCDWVULue
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ4oAm31JAlaovkLG5KsQD8AF2P3
7BKU70cVsnPwgra0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEyNzAyNTk1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB/QkoU4zO3tNiRQEYaQtveWlVahJQy0AAmjF/YoQ5xK9B9
RXrgf1yn769PMW2QpkAolkXOhcET3a16umRQ/icbX4OMqQQcp9rDhasZ96UHu/wQ6G13V/lGLrIk
lIbqjLeIC/tz47Pg6v7PzpwQ4jk34JVfzo30oVfsYBKgYY7U0bmq2vXVpOv6m5re/QCn7JUqQ99U
8hFQKaVuDBUD74gSGSlgFv2t/25HIWrXM27LB4sCjD8a9JqKu0zvf5VWEf79eSSJDcLZ3lfm1uQo
n1tJeiKMwI6fZXfePKOgD2JU0QzJZx/vQV0AKkZC66PF5+DOMANjPOCUro3Qfy9OEDzO
--00000000000028c9bb05f3360f39--
