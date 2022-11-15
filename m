Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62352629B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiKONu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiKONu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:50:28 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E200D24962;
        Tue, 15 Nov 2022 05:49:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E83D780E0;
        Tue, 15 Nov 2022 13:39:51 +0000 (UTC)
Date:   Tue, 15 Nov 2022 15:49:50 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        philipp@uvos.xyz, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
Message-ID: <Y3OY/l2ZBX+WbRR4@atomide.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
 <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221110 16:40]:
> On 10.11.22 г. 18:05 ч., Sebastian Reichel wrote:
> > Why do we care?
> >
> Because if we know the battery is genuine (or at least pretends to be :) ),
> then we can read battery parameters from nvram, see patch 3/3. This will
> allow us to charge HV LiPo batteries to 4.35V, using the full capacity.

Let's not enable charge voltages above 4.2V automatically at all unless
the user chooses to set a higher charge voltage via sysfs manually.

We have had reports of bloated batteries if left connected to the charger
at higher voltage than 4.2V. This seems to happen after connected for some
weeks or months. AFAIK this happens both with Android and mainline kernel
at higher voltages.

For more information, please see commit d4ee021c410f ("power: supply:
cpcap-charger: Limit voltage to 4.2V for battery").

No objections for using the NVRAM to detect the battery max voltages
though. That is as long as the default charge voltage does not go above
4.2V.

Regards,

Tony
