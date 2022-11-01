Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B161550A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiKAWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKAWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4A1DF3E;
        Tue,  1 Nov 2022 15:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE430B81DA0;
        Tue,  1 Nov 2022 22:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40711C433D6;
        Tue,  1 Nov 2022 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667341978;
        bh=Bcz/UDZU4z1PRQZH1CTWvaHW76z5ZeKr6HFFXnxmyQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DstVC8LcVVa3HyrkndcikVF7gQc3dWSImEr2nkidtbuEHBsMDLHn6nCBhYPjhhZxd
         Aza+1N06+N+xiLTfKOnfTXEkt1tnJ+FFBJR9b4Ap5Pii+22o8g6OqXVq0awhK+SUqa
         mI44+pQ109Ra5rYWsDulmEh5xIsDGD4OKBlfu+FQfggvFYIxJb2RWh4/grfxBXBUyP
         HH72n2qC35qeZKkNfOfjWkeCVBC+d+cBAOp2/JVGJr9WchaqrgxDsx9uxE8ZYZ6hYo
         8F+MTkUSNRpAAhwP2/T2CVzc7KkMlS9g9qOaDYAbycaZf5PDebTCD28ASffc4eOd+z
         XcwAID4rtjxsQ==
Received: by pali.im (Postfix)
        id 715297F8; Tue,  1 Nov 2022 23:32:55 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:32:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: syscon: Implement support for active-low
 property
Message-ID: <20221101223255.rhzerarzld45xfjh@pali>
References: <20220818172528.23062-1-pali@kernel.org>
 <20220818172528.23062-2-pali@kernel.org>
 <CACRpkdYWQVW_akJS7hvtU2=c063LCMfjN22X-neTfuTZRbt+yw@mail.gmail.com>
 <20220831114936.vukjsovdxw3cmj6h@pali>
 <20221009114043.6rdgpgzkngd527o7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009114043.6rdgpgzkngd527o7@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2022 13:40:43 Pali Rohár wrote:
> On Wednesday 31 August 2022 13:49:36 Pali Rohár wrote:
> > On Friday 26 August 2022 10:05:26 Linus Walleij wrote:
> > > On Thu, Aug 18, 2022 at 7:25 PM Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > > This new active-low property specify that LED has inverted logic
> > > > (0 - enable LED, 1 - disable LED).
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > 
> > > Yours,
> > > Linus Walleij
> > 
> > Is something else needed for this patch series?
> 
> PING?

PING?
