Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889146C03D0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCSSo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCSSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:44:25 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620941632B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=55TQw3vmH2ewB+u+Nx+NoaqSvHlaHxAFdFOoflwM9FY=;
        b=cFGyvjChe1mTdtFdX6pdqz0ATMgdpW3fT1KkwUrUkpNalQQDaqFU5vN7VKBddGpYLXta2DpkFI55w
         MogWKlXdSXzNrrC5bGiSlpq5Do4A2sQNeWaCmqIlEimeq9x1gl80wZc6zJUzkUhAOW1N6R5wz8ZVPd
         leZt4y4mpQn+ssBwEd/MBYswMDehgShJ7ooPBMIBmdbptpzJcDOW8EWJG0l7LOHAdSdye4j/hTjl2J
         OAiIf/mCrmSOrSub6eIq5J9qMPc36zFTeLyCvrYO7OvVztiKoy8rmG/+Gwak6H+EiJ+PByU8MKo+X5
         +j1pgZ4jnJU00weICutVZqABC1PMCAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=55TQw3vmH2ewB+u+Nx+NoaqSvHlaHxAFdFOoflwM9FY=;
        b=z5JZS1uRC8yuO9NKyeQdfLOOcdSuevOdrmWZPSc3Ui+aGG0zuuit9OrsPex0yW9dEql1YHNHq7Q2U
         ZbTuEn0DQ==
X-HalOne-ID: 0b8d9806-c686-11ed-a42d-11abd97b9443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 0b8d9806-c686-11ed-a42d-11abd97b9443;
        Sun, 19 Mar 2023 18:44:15 +0000 (UTC)
Date:   Sun, 19 Mar 2023 19:44:13 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        linuxppc-dev@lists.ozlabs.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 12/15] auxdisplay: ht16k33: Introduce
 backlight_get_brightness()
Message-ID: <ZBdX/YlexhyVzIRf@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-12-1bd9bafb351f@ravnborg.org>
 <CANiq72mFMJuec+r=T6xYtLpuU+a1rOrAhrHiecy_1Jpj2m4J=g@mail.gmail.com>
 <Y7qM+ZlG5gQiOW4K@ravnborg.org>
 <2857575f6ec206f79cc21d423fde7d17@protonic.nl>
 <20230319144408.03045c50@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319144408.03045c50@heffalump.sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:44:08PM +0100, Stephen Kitt wrote:
> Hi,
> 
> On Mon, 09 Jan 2023 11:12:02 +0100, Robin van der Gracht <robin@protonic.nl>
> wrote:
> > On 2023-01-08 10:29, Sam Ravnborg wrote:
> > > On Sat, Jan 07, 2023 at 10:02:38PM +0100, Miguel Ojeda wrote:  
> > >> On Sat, Jan 7, 2023 at 7:26 PM Sam Ravnborg via B4 Submission Endpoint
> > >> <devnull+sam.ravnborg.org@kernel.org> wrote:  
> > >> >
> > >> > Introduce backlight_get_brightness() to simplify logic
> > >> > and avoid direct access to backlight properties.  
> > >> 
> > >> Note: Stephen sent this one too a while ago (with some more details in
> > >> the commit message, which is always nice); and then he sent yesterday
> > >> v2 [1] (to mention the functional change with `BL_CORE_SUSPENDED`
> > >> [2]).  
> > > Thanks for the pointers. I will try to move forward with Stephen's
> > > patches.  
> > >> 
> > >> Anyway, if it goes via drm-misc, feel free to have my:
> > >> 
> > >>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
> > >> 
> > >> Though it would be nice to have Robin test the change.  
> > > 
> > > Robin - can I get your ack to apply Stephen's original v2 patch to
> > > drm-misc?  
> > 
> > done! see: 
> > https://lore.kernel.org/lkml/0b16391f997e6ed005a326e4e48f2033@protonic.nl/
> 
> As far as I can tell, this never got applied to drm-misc, and I don’t see it
> anywhere else. I guess it slipped through the cracks ;-)

Yes, I have been busy with a lot of other stuff lately, and cannot
promise when I get back to do Linux work.
So if someone else could pick it up that would be nice.

	Sam
