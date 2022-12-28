Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C694D6573AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiL1Hdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiL1HdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:33:17 -0500
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183CFCDA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672212765; bh=YlT9K+nNZROVTOUHORSIFse19Y2J/aGZoUQYjJlMKJ8=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=bVHX/3ZfF4TvUj5vOmRUqs6WyT3dhAf4oPQKUcLvO20ItM29nymdl8hXyPUe7LpUo
         6K5UExMlogf5uCxBRdc/LEmSh2aEZldrOXKJU8rpklciPiHHQo6c+sYUnp58qE+Vgm
         +XjyqHZIBEtegf4sXMZ195f5g/SOZtiqFqyRIIecAJDNv22j4EKuz5NSnj/AkyEbb+
         Q6P7zuMTKd9bR5AD3heQgG4cIACAj09GGZ5qWFHoITldAfWEDvhGrkuto2rE5iQEPc
         FbEfEenGN0Vl1O253zthNH51+7vSuh/c5BY0QkUD9r+2EtuyR6w9kfFn1iN7YJn10x
         E+r5GK4m5uZ9w==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id C77B66E1613;
        Wed, 28 Dec 2022 07:32:44 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
From:   Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <Y6vvxWUkJD7rCbgP@wedsonaf-dev>
Date:   Tue, 27 Dec 2022 23:32:33 -0800
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1013AB25-40DF-435B-B642-08C2FA4DBD91@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <B3B7C271-4C96-455E-A990-2AC7C52F703E@me.com> <Y6vvxWUkJD7rCbgP@wedsonaf-dev>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: K8Z-U9dTc7-iCdaPA-UAsfE7b-ivCS8W
X-Proofpoint-ORIG-GUID: K8Z-U9dTc7-iCdaPA-UAsfE7b-ivCS8W
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=880 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212280060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2022, at 11:27 PM, Wedson Almeida Filho <wedsonaf@gmail.com> =
wrote:
>=20
>  I suggest that you read the
> comments at the top of refcount.h?


Thank you for correcting me!  You=E2=80=99re absolutely right, and I =
completely misunderstood how `refcount_t` works.  Sorry for the noise!  =
I retract my comments on those two patches (the other two comments are =
unrelated).

=E2=80=94 Laine Taffin Altman=
