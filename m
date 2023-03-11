Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F26B5BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCKMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCKMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:31:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2C12DDC7;
        Sat, 11 Mar 2023 04:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4312760BA0;
        Sat, 11 Mar 2023 12:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C60EC4339B;
        Sat, 11 Mar 2023 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678537904;
        bh=p5iWwHAklWT0bySItEhojZIf18mXXNFhFCDhXndKyK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AamS5nNCIINdQ5gPbG0tS4TRoqFwguJYVQAPQdOqT8UJOgKafXRkL45eh6CrmqzJH
         3mSVmkZ2tsZvKuorrMmIP+YCyrxb7McFpweGnfNcVXbf9crDhcgeqV+OExB7JCMdNT
         OqFxDd+l3/imn6lB3eH9suY82ns7sXwGbjCP5El79TRmhR7CyhoLxs43J95oKQAPrg
         m9gw9o0Il0dzGUxaMgBVCVt7A5KnIcBtq1uC8L4t5HJx2UomOTurm1ghRFSDgPFDJX
         HQwhgPXRqRKkri7tWvX8xPGncaijbaMKwJ7hmeCZFVW5cCTxKWO/LGsjmX4WxczRt7
         uIRHR+Mp1vLTA==
Date:   Sat, 11 Mar 2023 12:31:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Todd Brandt <todd.e.brandt@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        todd.e.brandt@linux.intel.com, srinivas.pandruvada@linux.intel.com,
        jikos@kernel.org
Subject: Re: [PATCH] Fix buffer overrun in HID-SENSOR name.
Message-ID: <20230311123148.0fbe1091@jic23-huawei>
In-Reply-To: <b9dab02783e5eeaa74b291d4394150689e7c7b8a.camel@gmx.net>
References: <20230310235414.12467-1-todd.e.brandt@intel.com>
        <b9dab02783e5eeaa74b291d4394150689e7c7b8a.camel@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 01:53:22 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> This is exactly the fix I proposed. Thank you for testing and properly
> submitting it.
>=20
> Regards,
> Philipp Jungkamp

Looks good to me as well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>=20
> On Fri, 2023-03-10 at 15:54 -0800, Todd Brandt wrote:
> > Philipp Jungkamp created this fix, I'm simply submitting it. I've
> > verified it fixes bugzilla issue 217169.
> >=20
> > Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217169
> > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> > ---
> > =C2=A0drivers/hid/hid-sensor-custom.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > sensor-custom.c
> > index 3e3f89e01d81..d85398721659 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct
> > platform_device *pdev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct h=
id_sensor_hub_device
> > *hsdev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const st=
ruct
> > hid_sensor_custom_match *match)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_U=
SAGE_LENGTH];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_U=
SAGE_LENGTH] =3D { 0 };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_device =
*custom_pdev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *dev_name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *c; =20
>=20

