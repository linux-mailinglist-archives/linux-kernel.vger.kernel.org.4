Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E606D968E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDFL6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbjDFL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:57:32 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 04:54:58 PDT
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD1E53
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:54:58 -0700 (PDT)
Date:   Thu, 06 Apr 2023 11:44:55 +0000
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dZ9KpKqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1680781504; x=1681040704;
        bh=jDCBj8lshorW4gdkd4kJjUH+4/q9Xfg6ywnJShCYQyw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dZ9KpKqjZpp5ekB8Hwx8+atH3RXHtHtb8jmwcgcxXYUdxq3S5rnRvb6cG4JLo2Gnm
         EN1w+HfX+LY6vfSUh5jAQujFu1YzwnJkbqNXXgDur99xiTx631qZQejUg/yV/ZmNkf
         +pps5DwM7jmDLZKedntQZACZjQ1UWk8ng/xtOMgGlOdDmUxlLgqC4EJImgFKO4Ao2e
         um4qiqDRJvzu3RT5NbJly5Q/Qw0c2pc1tiEoW5dOgY22o7C74Jr4Rkfz5wnhgBHTdn
         SGYczFCacdgmFxBo+8mYgdxk87TFwM24WQ8lRnRXwcC2eJXRQ7Cu986BlW9+QxNrb5
         QWf7kSBD4vN2Q==
To:     =?utf-8?Q?Petr_Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
From:   Juerg Haefliger <juergh@proton.me>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Message-ID: <20230406134440.72959135@gollum>
In-Reply-To: <20230331110043.7b1ddfa3@meshulam.tesarici.cz>
References: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com> <20230331092553.677e9649@smeagol> <20230331110043.7b1ddfa3@meshulam.tesarici.cz>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_ayphHOVkQ7156P23PkrcwNhMKb9WleLOMbnybo3AJ1Q"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_ayphHOVkQ7156P23PkrcwNhMKb9WleLOMbnybo3AJ1Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Mar 2023 11:00:43 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> Hi Juerg,
>
> On Fri, 31 Mar 2023 07:26:09 +0000
> Juerg Haefliger <juergh@proton.me> wrote:
>
> > On Tue, 28 Mar 2023 09:54:35 +0200
> > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> >
> >[...]
> > > Anyway, I suspected that the buffers need not be imported into the vc=
4
> > > driver (also hinted by Eric Anholt in a 2018 blog post [1]), and it
> > > seems I was right. I encountered the issue with Ubuntu 22.10; I
> > > installed latest openSUSE Tumbleweed yesterday, and I was not able to
> > > reproduce the issue there, most likely because the Mesa drivers have
> > > been fixed meanwhile. This makes the specific case of the Raspberry P=
i 4
> > > drivers moot. The issue may still affect other combinations of driver=
s,
> > > but I don't have any other real-world example ATM.
> >
> > I'm only seeing this problem with Wayland, no issue when switching Ubun=
tu to
> > X. It seems Tumbleweed is using X by default.
>
> I know; I was the team lead of SUSE low-level graphics engineers until
> end of last year... I have just double-checked, but this output of
> wayland-info in the GNOME session accessed over RDP is quite convincing:

It sure is but how did you get that?? For me it's:
$ wayland-info
failed to create display: No such file or directory

And from strace:
connect(3, {sa_family=3DAF_UNIX, sun_path=3D"/run/user/1000/wayland-0"}, 27=
) =3D -1 ENOENT (No such file or directory)

Which is kind of expected when running X, no?
$ ps -ef | grep -iP 'xorg|wayland'
opensuse  1377  1375  0 09:13 tty2     00:00:16 /usr/bin/Xorg.bin vt2 -disp=
layfd 3 -auth /run/user/1000/gdm/Xauthority -nolisten tcp -background none =
-noreset -keeptty -novtswitch -verbose 3

What am I missing?

...Juerg



> interface: 'wl_compositor',                              version:  5, nam=
e:  1
> interface: 'wl_shm',                                     version:  1, nam=
e:  2
>         formats (fourcc):
>         0x48344258 =3D 'XB4H'
>         0x48344241 =3D 'AB4H'
>         0x48345258 =3D 'XR4H'
>         0x48345241 =3D 'AR4H'
>         0x30334258 =3D 'XB30'
>         0x30334241 =3D 'AB30'
>         0x30335258 =3D 'XR30'
>         0x30335241 =3D 'AR30'
>         0x36314752 =3D 'RG16'
>         0x34324258 =3D 'XB24'
>         0x34324241 =3D 'AB24'
>                  1 =3D 'XR24'
>                  0 =3D 'AR24'
> interface: 'wl_output',                                  version:  3, nam=
e:  3
>         x: 0, y: 0, scale: 1,
>         physical_width: 430 mm, physical_height: 270 mm,
>         make: 'FUS', model: 'P20W-5 ECO',
>         subpixel_orientation: unknown, output_transform: normal,
>         mode:
>                 width: 1680 px, height: 1050 px, refresh: 59.954 Hz,
>                 flags: current preferred
> interface: 'zxdg_output_manager_v1',                     version:  3, nam=
e:  4
>         xdg_output_v1
>                 output: 3
>                 name: 'HDMI-1'
>                 description: 'Fujitsu Siemens Computers GmbH 20"'
>                 logical_x: 0, logical_y: 0
>                 logical_width: 1680, logical_height: 1050
> interface: 'wl_data_device_manager',                     version:  3, nam=
e:  5
> interface: 'zwp_primary_selection_device_manager_v1',    version:  1, nam=
e:  6
> interface: 'wl_subcompositor',                           version:  1, nam=
e:  7
> interface: 'xdg_wm_base',                                version:  4, nam=
e:  8
> interface: 'gtk_shell1',                                 version:  5, nam=
e:  9
> interface: 'wp_viewporter',                              version:  1, nam=
e: 10
> interface: 'zwp_pointer_gestures_v1',                    version:  3, nam=
e: 11
> interface: 'zwp_tablet_manager_v2',                      version:  1, nam=
e: 12
> interface: 'wl_seat',                                    version:  8, nam=
e: 13
>         name: seat0
>         capabilities: pointer keyboard
>         keyboard repeat rate: 33
>         keyboard repeat delay: 500
> interface: 'zwp_relative_pointer_manager_v1',            version:  1, nam=
e: 14
> interface: 'zwp_pointer_constraints_v1',                 version:  1, nam=
e: 15
> interface: 'zxdg_exporter_v1',                           version:  1, nam=
e: 16
> interface: 'zxdg_importer_v1',                           version:  1, nam=
e: 17
> interface: 'zwp_linux_dmabuf_v1',                        version:  3, nam=
e: 18
>         formats (fourcc) and modifiers (names):
>         0x48344258 =3D 'XB4H'; 0x00ffffffffffffff =3D INVALID
>         0x48344241 =3D 'AB4H'; 0x00ffffffffffffff =3D INVALID
>         0x36314752 =3D 'RG16'; 0x00ffffffffffffff =3D INVALID
>         0x30334258 =3D 'XB30'; 0x00ffffffffffffff =3D INVALID
>         0x30335258 =3D 'XR30'; 0x00ffffffffffffff =3D INVALID
>         0x30334241 =3D 'AB30'; 0x00ffffffffffffff =3D INVALID
>         0x30335241 =3D 'AR30'; 0x00ffffffffffffff =3D INVALID
>         0x34324258 =3D 'XB24'; 0x00ffffffffffffff =3D INVALID
>         0x34325258 =3D 'XR24'; 0x00ffffffffffffff =3D INVALID
>         0x34324241 =3D 'AB24'; 0x00ffffffffffffff =3D INVALID
>         0x34325241 =3D 'AR24'; 0x00ffffffffffffff =3D INVALID
> interface: 'wp_single_pixel_buffer_manager_v1',          version:  1, nam=
e: 19
> interface: 'zwp_keyboard_shortcuts_inhibit_manager_v1',  version:  1, nam=
e: 20
> interface: 'zwp_text_input_manager_v3',                  version:  1, nam=
e: 21
> interface: 'wp_presentation',                            version:  1, nam=
e: 22
>         presentation clock id: 1 (CLOCK_MONOTONIC)
> interface: 'xdg_activation_v1',                          version:  1, nam=
e: 23
>
> Petr T


--b1_ayphHOVkQ7156P23PkrcwNhMKb9WleLOMbnybo3AJ1Q
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbVF1c0tnQUNna1FEOU9MQ1F1bQ0KUXJlM3l3LytNd1BWaE5Y
MjB0T3NzcW1vQnVwWFphMElzZGtpc0k4WnBIN2VrTHMveXZtZlRPRnRSQURqdVFndQ0Kdmg3RHEx
N3RieGdyb0FLRU9ydjNuT2s4RVplWkZlZ2NTK0k3TnVhYVpEQUJhV0ZOQ1NjSlp0TkYrRUt4L2xX
Tw0KdDluaEFRajVHK1JUZ2RrUmVla1A3aEpHeFVJRmhtWVpQM00zTVdwaFFqMTJLSnJTWWpYREhB
akJMNDRFYnh5aQ0Kbi9vTEplRld6TUJBUWh4K0JDTlpqY1dHRlZGUnVOdlJhZE5EbXlrVFB5eWVw
WTlUdWV5TWc1TGJXcHZLM2p3bw0KM25hOHRwd2U4T0UvbHlvSHBmVVVSWVQ3UjFMeWtMNkR0N3B4
c25hQUJ6QkJqalZiLzhHVkdFYUFybU1BdCtWcw0Kd2FmTEhLUjlTM2ROT1FJUVBJNmFwUmZhZEF4
QzBzNDBNQTdJOStvMFQxV25KUzdVdS9xVi9DODFVdHlZelpIaw0KYnFHbUIyQ0FCNS85cmVZTTVm
WXorNVdROTFSSnVMeWlqV3krTG9iOGlYMVMxWnJla005V01ocXpxZzFhQXgzSA0KTGdIYUd5WkZG
citBTUZ2MUN1czA2WFBKQVI1aWF3dU5OaTJwYWNEMXJacXhzSTd2QTk4R0ZzNjNFN3NjSjhMRg0K
NVljS0pVRGppeDR2U2s4NjdIUGJPQ3BLVWZ1dzNjMi9weG5Oc0Q0L0FDQ2Z1QnFnSzRqV1E1L08x
Qksxa0pqag0KdUp1SEhjVU5ydWRPcE05U3lrblZ6TXlZeUcrWDhUbW1RT1dkR0xoQlRKbUtxejB0
WldtMkZlKzdLS3U4MWtkMA0KY05vS1E0akpQN2k0NkJicWxnQ0phU2hiamNKY2U1SmFTSWJ1OWp1
WDVDZU9qSDI1Mkc4PQ0KPXhrdmYNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_ayphHOVkQ7156P23PkrcwNhMKb9WleLOMbnybo3AJ1Q--

