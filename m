Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113EF6A2961
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBYLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBYLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:51:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE9EB56;
        Sat, 25 Feb 2023 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677325907; i=w_armin@gmx.de;
        bh=oG+tB6ssXoXEofK3HsqQ2ix++xKtWIxgzJb4QDsF1RA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=m0kC9ZVcpnUqA4EuBCq+71qCSzBxNegN2ifJFDshV5QtfMY9B0m35XD0mq0saOIOG
         JYlHWK7ZLf+NilYAaphysJf8b8x0DitineoCnJLg3+It/0h+GOb73rqg0+tFmrpa18
         7F2jhXjPgrrMn0zhVfn5IfNP2crNapqOGeCGhRnN2XD7nqHWoqi/HewKffyjc9/+3x
         asEy1temCqygFlIeVVmnMjJtwOUmh7+wnlkZjUBfbhyc5Pn/7yYbDVyQyfbzvKv9QH
         GK5wK3qNadULlLVWmA3q4ehGF3G06KACvSj2mTAj8Zgb0s7H1OC50mWPwhQGSPGWL6
         RJvm9+T5KLdQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mo6qp-1ohNvM2pvn-00pdnA; Sat, 25 Feb 2023 12:51:47 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ACPI: SBS: Fix various issues
Date:   Sat, 25 Feb 2023 12:51:40 +0100
Message-Id: <20230225115144.31212-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSdh3QZ5TfA72bLW4j1TVQlYE9Fz2wCZXYtXmxMQ+OHSSgW9vsY
 dvBM5ju6D46RQJ7mKCFz+vxglSJ4ZGNHZNCPcOnsOPUrwrBBufwxgqJlQWyX7M1aGLDWoEo
 yKUZdUeTElgtL1lcvCLUWUBEnv5LppkMbuEclIRoo2uJWCQ9v/93WSh5DYcMctx/WcbOmQ0
 Lvy9g2SUYGZSP3MloojSA==
UI-OutboundReport: notjunk:1;M01:P0:s79fxxbmHAs=;9AYyQVcWuaWsP5nnzWsb0BVuw85
 Qw8Ua0fIFB2hymSCIH5ygLwKYdFfIY9GMK7COcqZ3A+42TjxpJr48ueuR0ELjevzmncrb2FF6
 Vg55uRHJKU1B/3PXWh2ycqPGzVmEog8gBpt+Gu1qZs1YC94FbiGXaH2tPVt6mRzP044qXNMSo
 CrTf2V8hXGK40Pa4gBvO3sUj1F2nhuy71IdRDkJDyMxsApWdSOJzzhaX6UMroNnduoW8zFSjS
 dumoE5+85tfp0GqqwKL4aniodU0wMywsuQBkQX7OOYa67t+g8QAmnIjZlb4wAQxfNggH7xTcE
 nqFlmUK9eOFui5SZf9jVrOoQyXgNu/GOMhdsIZIQu9MzUCqMVUvLKZvuMcZ2cbd9QHxJ3t18F
 BoxuBlyZvRYreEeNMdrq4ng3Vvu0+k4apWUXhGz36viXif/LlCA9QGEOar+i2t8JU0lFankM5
 XDmTUYd3Pc/zlW+Fh+LCp/MOPznDDY8DYrb7VewnscWc7sV7Z4y5jLm10xMfOjYZSRSXH/vid
 zJWIrNGgGVzar6QX2KcEA5aEphUaPkYKmUfxS6tc34KfzxwO0SaQKeZmk6/i8AAATtOJ+bU9T
 4dGdQOQAZJe3yZO/xNmvSld9TJnbEk8l2VXYaAAe71xpEpUy4Kjk0ydyYbNvZA8Ui8wyYVlM4
 BGLx0DNHk0ZjYIzPhwNHGTygXrwhnIzm5SazCKj9aJ/BlB00aoEHZ64F6EV0YReELOqui8TSe
 7geq8vYp9A47ckTsj4Lp6z5a9sl6YuZ9eHCL4Jqgsjb/rCAU1dUTX9eLpB5WI5Vt1hQG5iTv+
 fSLGs+4Sz6qGXZni0CRUumTy7tyKSny+QC438BLXSrvwNzo9dSMYhnwj4wwoKC0R2pYayhxSY
 Uq7yDPJCPLzxFBpcXK5tKmFaeS18D5+M4/U6zJeOEMTCjYE7WpLDH6TXLRY9xSXBD9ooGHkDN
 Mhp2+FTXiVUfkLRbJ1d5GZEiaF8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Acer Travelmate 4002WLMi, the system locks up upon
suspend/shutdown. After a lot of research, it turned out
that the sbs module was the culprit. The driver would not
correctly mask out the value used to select a battery using
the "Smart Battery Selector" (subset of the "Smart Battery Manager").
This accidentally caused a invalid power source to be selected,
which was automatically corrected by the selector. Upon
notifing the host about the corrected power source, some batteries
would be selected for re-reading, causing a endless loop.
This would lead to some workqueues filling up, which caused the
lockup upon suspend/shutdown.

The first three patches fix a stacktrace on module removal caused
by some locking issues. The last patch finally fixes the
suspend/shutdown issues.

As a side note: This was the first machine on which i installed Linux,
to finally fixing this took ~5 years of tinkering.
=2D--
Changes in v2:
- make acpi_ec_add_query_handler() static to fix warning

Armin Wolf (4):
  ACPI: EC: Add query notifier support
  ACPI: sbshc: Use ec query notifier call chain
  ACPI: EC: Make query handlers private
  ACPI: SBS: Fix handling of Smart Battery Selectors

 drivers/acpi/ec.c       | 44 ++++++++++++++++++++--------------------
 drivers/acpi/internal.h | 10 ++++-----
 drivers/acpi/sbs.c      | 27 ++++++++++++++++---------
 drivers/acpi/sbshc.c    | 45 ++++++++++++++++++++++++++---------------
 4 files changed, 74 insertions(+), 52 deletions(-)

=2D-
2.30.2

