Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF004661930
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjAHURw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:17:50 -0500
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8FAF02F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PODDs8JDufzZ5a9dupsEdgaudxmeqyPeKP5ITgSRl68=;
        b=nBJo32bQiToZqdwB6CPRHuCJyPXi9tZMgvcrXF7vWhSIw7x4LfzX1kEgyU6pZhHCE+MrGZRIKneGu
         0xhUarLzRrzg6q1lNz9W+nEGr57in/yjz4lNHZOC0uofaf04NEXEHDNBPKYZEPplSs27985GpcpgPI
         qF+kOZrElEOZFKfY/CcQ7P1xZxS9MpPGYtrhbvp8FiRl/iiztjxYlHKQUgUF+kUyRNDM1aCjmWY1hT
         JfCzjW9vKX8XEaMuzf/p3jq/PDkUISjK90kPjjuYg86yFOtpgWPSk/dHY0dByW2FLHTNMm6GHfEPON
         BacDviJrBLTbV2ko8XMUrQiERLNY0rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PODDs8JDufzZ5a9dupsEdgaudxmeqyPeKP5ITgSRl68=;
        b=6IctTMa76KOnO4IvloCnpEUgy/yBpRV0cPD9/N/HRaXCs/MtK1AklBan9+oNUjcARf6AjTLKbnCYO
         8JWZTp2DQ==
X-HalOne-ID: 8170d7cb-8f91-11ed-b31b-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 8170d7cb-8f91-11ed-b31b-cde5ad41a1dd;
        Sun, 08 Jan 2023 20:17:45 +0000 (UTC)
Date:   Sun, 8 Jan 2023 21:17:43 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Kitt <steve@sk2.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
Message-ID: <Y7sk51V5d3P+Uk8x@ravnborg.org>
References: <20230106143002.1434266-1-steve@sk2.org>
 <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
 <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com>
 <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
 <CANiq72=8T4=NhxLqeV0vgynRB0+gy9VnddZNTKXP75UfVPnc+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=8T4=NhxLqeV0vgynRB0+gy9VnddZNTKXP75UfVPnc+Q@mail.gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

On Sun, Jan 08, 2023 at 08:11:52PM +0100, Miguel Ojeda wrote:
> On Sun, Jan 8, 2023 at 7:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Oh, I sent it here because of
> > https://lore.kernel.org/all/Y7qM+ZlG5gQiOW4K@ravnborg.org ?
> 
> Yeah, sorry. I mentioned it just in case, since Sam asked for Robin's
> Ack in that thread, but I should have probably just Cc'd him here
> (done!)...

Stephen notified me that the patch is already applied - so no need for
anything now. Sorry for the noise!

	Sam
