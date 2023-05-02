Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1546F4DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEBXpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEBXpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:45:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12815E6;
        Tue,  2 May 2023 16:45:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so43981271fa.2;
        Tue, 02 May 2023 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683071101; x=1685663101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxCHWliQRwTwHSwjl2MyQ3HUU9SoEdGxHURTWvn8V/o=;
        b=cwjPfYEQXlHeHdUDRAMrSR3x/0oLyTxJOLg6C53RMqnxkTpI9/MO6tCGb8U8YAj/dz
         UiU1uSUnqEqmBoLIdyZEqZFSxvAySeBWoaeWD1ISNqh4IxDAxzGkj9sUJlf2/JFJi08X
         wVWlmgSbvqNy6gBYDsHXoSb2FCIZ8noHtSpuFnk+1tYsE45DRBVa2HM5KvUN8xBv4kr+
         iGOzKTfBCZqDPyyj6RYGDH10sAyVgyhf4drfVXA/cELevIIFFN7/p7IelaoueD06NE1p
         A40AzHsbsdWi2frL6qQlZzWdys1tym1Wb9EdOTGIPv1xveN+8SlCoeRZzFT5J0eOkhAS
         fEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071101; x=1685663101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxCHWliQRwTwHSwjl2MyQ3HUU9SoEdGxHURTWvn8V/o=;
        b=Szh606a8dPvVUaQC97vQMRv9tX5aAUWFfkbCFH8wZ8gGJE5kdfSxNxpxT3hq2+7wEX
         au0/tYbKqRkU0PeX/mQ+UVAEUVuQzQWbrnG2zDo1/2ZiDCJBgoLaKejr+RhKz0l2BETY
         HVRHWTF39qFcuUdyIG3Gz1WUnCWi2K8c6wt3XfXC6MPG3lwQ+IVfydR7I9GWIi5jZCkF
         VrX3a9DRJhGglEmHpM5CEWMYdSfGXU+3fPK44L3KBhwbq1ynqJeqzDOzysMygHkM9D+U
         5aiytKi/C621k/4x6cZW1xB2oBNlk/xhet0fIjtzNNdZ85cHy73ur8RBOHYMCPIws4xk
         yXjQ==
X-Gm-Message-State: AC+VfDwzHQ/SMKSBhkrV6X/b9bdQ/i0WfzibLGq+QBFlmE6M5x9//Ns9
        LFUqQ97tvmNtKOmi0X+EcX02bDoaN4KktHc0uP4=
X-Google-Smtp-Source: ACHHUZ5MVQCw1xivPn/+3SAWqxnBScSKv8/ogt7IkbANc0sj+NTIqcWnjesc1wxlsmIjFao/BS8Ooxq2LrQx1loxhTg=
X-Received: by 2002:a2e:9490:0:b0:2a7:a719:5936 with SMTP id
 c16-20020a2e9490000000b002a7a7195936mr5402755ljh.19.1683071100926; Tue, 02
 May 2023 16:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230424133542.14383-1-johan+linaro@kernel.org> <20230424133542.14383-2-johan+linaro@kernel.org>
In-Reply-To: <20230424133542.14383-2-johan+linaro@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 May 2023 16:44:48 -0700
Message-ID: <CABBYNZ++1hjeP9r-3Y4j6gPx42-Gk6dNZOYzuRe5bgdz+YHL6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: fix invalid-bdaddr quirk for
 non-persistent setup
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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

Hi Johan,

On Mon, Apr 24, 2023 at 6:35=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Devices that lack persistent storage for the device address can indicate
> this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
> to be marked as unconfigured until user space has set a valid address.
>
> Once configured, the device address must be set on every setup for
> controllers with HCI_QUIRK_NON_PERSISTENT_SETUP to avoid marking the
> controller as unconfigured and requiring the address to be set again.
>
> Fixes: 740011cfe948 ("Bluetooth: Add new quirk for non-persistent setup s=
ettings")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  net/bluetooth/hci_sync.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a8785126df75..f45598b5a532 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4573,23 +4573,17 @@ static int hci_dev_setup_sync(struct hci_dev *hde=
v)
>         invalid_bdaddr =3D test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quir=
ks);
>
>         if (!ret) {
> -               if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks=
)) {
> -                       if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> -                               hci_dev_get_bd_addr_from_property(hdev);
> -
> -                       if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> -                           hdev->set_bdaddr) {
> -                               ret =3D hdev->set_bdaddr(hdev,
> -                                                      &hdev->public_addr=
);
> -
> -                               /* If setting of the BD_ADDR from the dev=
ice
> -                                * property succeeds, then treat the addr=
ess
> -                                * as valid even if the invalid BD_ADDR
> -                                * quirk indicates otherwise.
> -                                */
> -                               if (!ret)
> -                                       invalid_bdaddr =3D false;
> -                       }
> +               if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks=
) &&
> +                   !bacmp(&hdev->public_addr, BDADDR_ANY))
> +                       hci_dev_get_bd_addr_from_property(hdev);
> +
> +               if ((invalid_bdaddr ||
> +                    test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirk=
s)) &&
> +                   bacmp(&hdev->public_addr, BDADDR_ANY) &&
> +                   hdev->set_bdaddr) {
> +                       ret =3D hdev->set_bdaddr(hdev, &hdev->public_addr=
);
> +                       if (!ret)
> +                               invalid_bdaddr =3D false;

I'd keep the original comments since it appears you haven't changed
its logic with respect to invalid_bdaddr.

>                 }
>         }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
