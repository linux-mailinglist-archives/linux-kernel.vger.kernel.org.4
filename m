Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E36C2347
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCTU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCTU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:59:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67659F7;
        Mon, 20 Mar 2023 13:59:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so16619907lfr.1;
        Mon, 20 Mar 2023 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wdRIgcY7Wk+vGvoS1kaRTmzag7+Y3UY2FpHXNBgXvs=;
        b=Nm3Y99OB9aFwl0pabiX5CZeYbKNWtMBZyPrYWkRf4g+imrSzCam4brI1ewqNUBCz2U
         kMHwjOgbL+RXpmj8gSV7l/6UEjrZZ++v2kMZDg7Um2/3O0N9DDB6Pol0hNV767Y8MsQo
         +xBctop95NN6REtVjVQDvCv7M/1pG25yk6dWqzVii+d1bYYtnoG5pGjj3qm3flvuU10Y
         Dv329b5pdKEryPxOfZ0LDgLWyFFe2rnH7CbGx4MWscf8q8gqmRObcPmvqPUdZgq0t8AP
         hEzuxLiP9rivuTL52sFuZ9GXWAgZvJaQLGdtWhkomhn76hVYuztJsl3gtE38OVqSYDF3
         O1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wdRIgcY7Wk+vGvoS1kaRTmzag7+Y3UY2FpHXNBgXvs=;
        b=tV6D0FJ0kKNASQc6z4cagh5PB4tz+ZmIjz0xeun9mv9cPjHBKKxgJfZq/IQCy5Zhky
         uzG1XcSWXMypyUKx+CU7f7jB7pJ8FESeLwglgffYT0y7r5Csb+TwY8rQpYCSsDPUe7UB
         N81iVCyLviBUprfEfS35ytul6CDwX4t8kqxN7XZR2Fpu2vsAAISMM3yC9skw6PLY5QpK
         PKnDQHD8cQlnM2qJCz6i3rurHVn1Sk0mRWTZS2VH8BHm+eyBXZxijiVVTMmYAOGkCVuy
         O5CtNU9tkuOb934Q8R6d69BIwrdXwhI/nKdtQNVwA8OqatV2noAJRECsS+zCOT4AxLeO
         5X+g==
X-Gm-Message-State: AO0yUKXP4pWeFVLPgS8r5oDcWTTYIBuFwFbNecTTZmNOQ5hk3zevknGM
        iK75JCvWDBCtp3Snsf+F9XWhG00imKIEsHhsBBA=
X-Google-Smtp-Source: AK7set+GZMOV2oPYZrJasjIPI1HMHAl8AQeBQ9R07smtrNPJoB8+7sP4Wq8Ktz7t6X+MuWN17iwbVFfaFiLRZuVhDUk=
X-Received: by 2002:ac2:5625:0:b0:4d5:ca32:6ed5 with SMTP id
 b5-20020ac25625000000b004d5ca326ed5mr282905lff.3.1679345961969; Mon, 20 Mar
 2023 13:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230318150555.1705749-1-alvin@pqrs.dk>
In-Reply-To: <20230318150555.1705749-1-alvin@pqrs.dk>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 21 Mar 2023 05:58:45 +0900
Message-ID: <CAGTfZH2P=xDkRswWz6GdVpETVqO8HBSSG_+6vQ3EjLq2HmM6Yg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] extcon: usbc-tusb320: add accessory detection support
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 12:19=E2=80=AFAM Alvin =C5=A0ipraga <alvin@pqrs.dk>=
 wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> The TUSB320 can detect the following types of accessory:
>
>   - Audio Accessory
>   - Audio Accessory with charge-thru
>   - Debug Accessory (DFP)
>   - Debug Accessory (UFP)
>
> Moreover, the typec subsystem can be informed of this through the
> typec_set_mode() function. The information will be propagated to any
> linked typec muxes. Add the necessary support to the driver.
>
> Note that for the Debug Accessory modes, an educated guess was made that
> for the USB data role, DFP implies HOST and UFP implies DEVICE. But this
> might want to be made configurable at a later date.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> v3: add Heikki's Acked-by
> v2: no change
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 90 +++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 22 deletions(-)
>

(snip)

Applied them. Thanks.

Best Regards,
Chanwoo Choi
