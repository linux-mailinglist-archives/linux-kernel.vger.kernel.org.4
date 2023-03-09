Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E46B2C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCISFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCISFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:05:31 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89864B11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:05:26 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id p6so1607746pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678385125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0ABrZm/laoJveDOwjUgnffZfJ7ABmuxocnfWkNK1LQ=;
        b=Ib5A+VKJ9AXsDTMUML0lAyCo2bqRQgJEGgzIdcZWg56TYbo0NjME+67h1B+jIoRgTH
         9nF9p9VxDberc1h0DAdi1WUNp48qKLqCIegf14XI2/Ve+tb/+NJRNikf8Thlyt4aMARU
         P2Em94wS8lmVGlodo8MuPf7/Kv83aZQbN3B0tuvcMvtsimwK2zX4UXZ/0VKmQ3/6Iuyu
         48SQZcaJGgXEBIH3+5o6IFFV8PGbTBxjS7qO2zJnevwsVNMuGR3E9fzZWXa17/QkdiIZ
         ouCLVIXOBJDckdSU6DG3uWBcM4tlri+npZrhfyPhPny6i2hTzHdvb7giNhR+MBeJviVb
         S03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0ABrZm/laoJveDOwjUgnffZfJ7ABmuxocnfWkNK1LQ=;
        b=IAw1GYaGVlGvbhmVgvb89JG/TGmecLaHG0a9lFDQcJ1ovaErCv1ykM5Hqndnyc0J05
         bnB/aMFZFfbhZzwZAo/GGlYF+S8jE0jxqTaCOf6jpNWH2RI/fSyQlUWzabSxFuQhc48c
         T9BVu/yuONdbWUHZO2CRIIHyTlpvJX3y/2M0KHi8tBdSrj1by/s4Bm/WH5v4Nm+Wrul0
         WTm5H0MWAQUtpyT0mwFdvzPavsbuvLnxOs/qdS+4TwzCr/p1EHRXfYjPamGJQzayJbfJ
         DzHd8ik2WtsijWkJjBGtyNvhPB9MuFUQ2iEjuF0OxrIiEaGJIWUUNrXg9dIX+j9WfE7S
         tHWQ==
X-Gm-Message-State: AO0yUKWQlaFGaiLS2MwKRAOR5LNR56eY9Ed18E5QEyxcs6wnVHp2Rb1M
        S5f+br4FINmIlRU38BtfdQBwy0wd6jjX+CCbEDMxSQ==
X-Google-Smtp-Source: AK7set92xctTDshGXs7o6XU97WD5hd+EVosmSQEaNti+rPIQop4SET3skwXSjtatn9JSUpARwMLWeA2lKCRK0bniSTE=
X-Received: by 2002:a65:680e:0:b0:503:912f:d116 with SMTP id
 l14-20020a65680e000000b00503912fd116mr743400pgt.3.1678385125388; Thu, 09 Mar
 2023 10:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
In-Reply-To: <20230301214952.2190757-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 9 Mar 2023 10:04:49 -0800
Message-ID: <CAGETcx_DTHW4-WMK4qRhvhxiunUB2f79cpXSfQ1x-hifZQ+tgw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Don't pull in this series please. It needs more testing from the folks
I cc'ed and it's already breaking things for Martin. This needs more
revisions.

-Saravana

On Wed, Mar 1, 2023 at 1:49=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> Yongqin, Martin, Amelie,
>
> We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> ("mtd: mtdpart: Don't create platform device that'll never probe"),
> fw_devlink is smarter and doesn't depend on compatible property. So, I
> don't think these calls are needed anymore. But I don't have these
> devices to test on and be sure and the hardware I use to test changes
> doesn't have this issue either.
>
> Can you please test these changes on the hardware where you hit the
> issue to make sure things work as expected?
>
> Yongqin, If you didn't have the context, this affected hikey960.
>
> Greg,
>
> Let's wait for some tests before we land these.
>
> Thanks,
> Saravana
>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
>
> Saravana Kannan (4):
>   usb: typec: stusb160x: Remove use of
>     fw_devlink_purge_absent_suppliers()
>   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
>   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
>   driver core: Delete fw_devlink_purge_absent_suppliers()
>
>  drivers/base/core.c           | 16 ----------------
>  drivers/usb/typec/stusb160x.c |  9 ---------
>  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
>  drivers/usb/typec/tipd/core.c |  9 ---------
>  include/linux/fwnode.h        |  1 -
>  5 files changed, 44 deletions(-)
>
> --
> 2.39.2.722.g9855ee24e9-goog
>
