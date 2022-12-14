Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F364D146
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiLNUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLNUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:34:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA815A06
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:26:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id a9so4574995pld.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh4yGehAyQJCJcuCoTUcjUGUaqnKdiIyumNVBBoltls=;
        b=mPfS7rDdA1s7OTuDzJeeqaUtQWdvhXiih4DaBQOnP+ywJ7La+MD0l12mJosgd8XfM3
         F98kw2tmQ+lmo6x0b6y9gTDp917KPrZluMrQBhWw3TT4FaylKvMoj94VaJMowlU/4DEc
         w9aRhEK8O9dXCaXx3wcZeQoOnyuLZSFQhhdhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4yGehAyQJCJcuCoTUcjUGUaqnKdiIyumNVBBoltls=;
        b=J+kpu0LyYsMcaJwbuflAdIzZRTPadC7QQiiPimeY3wPzO0j4drZ0SklTqbhCXhlHbE
         0I1Z8MgsnroSF8bqmFuYyUmmcpeknpDEWuxaMoKBCEnVvymLo3o+TDD/nTlpqIN+NgIh
         LThsXxZnTyQ/8LxXRYWHQEhBbOiw7D1rFJxtTRYepzte4Y1vPlcZaF24IVVkU+VdRTVG
         wHUcer9MnirbfKnhbWLuARLcwHbr/pTNAEM7eeDoQRc1vjaWQGfZOLTmYDBWVE4V6E/G
         YTsDhu+yEdSgyPQs1qDe0eBBTbgNRVWR/7zR1lD02LvsV1280KhzOcOggpsy8K2M+xHh
         uYNQ==
X-Gm-Message-State: ANoB5pmA0UmzDkxG9SIa+W8aWjeOj54qA40GnH+Rz7YoYNlLgTw8+Ran
        M10FJk+Gwpjcx8ddertU4kX6UQ==
X-Google-Smtp-Source: AA0mqf7FoxAXGVCaAYq4lYgr5geZVyiJpNRinfwIOMZiNGfj3Iz317dw/JX5LxLhBT+d3CYDPhICFw==
X-Received: by 2002:a17:902:8f8c:b0:186:7fe2:eb4e with SMTP id z12-20020a1709028f8c00b001867fe2eb4emr24274813plo.48.1671049562476;
        Wed, 14 Dec 2022 12:26:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001897de9bae3sm2264124pla.204.2022.12.14.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:26:01 -0800 (PST)
Date:   Wed, 14 Dec 2022 12:26:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <202212141224.0D30B9E@keescook>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5otilaHc6HBPCAF@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:09:46AM +1300, Paulo Miguel Almeida wrote:
> On Wed, Dec 14, 2022 at 11:29:37AM -0800, Kees Cook wrote:
> > On Wed, Dec 14, 2022 at 09:42:00PM +1300, Paulo Miguel Almeida wrote:
> > > One-element arrays are deprecated, and we are replacing them with
> > > flexible array members instead. So, replace one-element array with
> > > flexible-array member in struct RXBUF and refactor the rest of the code
> > > accordingly.
> > > 
> > > It's worth mentioning that doing a build before/after this patch
> > > results in no binary output differences.
> > > 
> > > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > > routines on memcpy() and help us make progress towards globally
> > > enabling -fstrict-flex-arrays=3 [1].
> > > 
> > > Link: https://github.com/KSPP/linux/issues/79
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> > > 
> > > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > > ---
> > >  drivers/char/pcmcia/synclink_cs.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> > > index b2735be81ab2..1ab2d552f498 100644
> > > --- a/drivers/char/pcmcia/synclink_cs.c
> > > +++ b/drivers/char/pcmcia/synclink_cs.c
> > > @@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
> > >  typedef struct {
> > >  	int count;
> > >  	unsigned char status;
> > > -	char data[1];
> > > +	char data[];
> > >  } RXBUF;
> > >  
> > >  /* The queue of BH actions to be performed */
> > > @@ -2611,7 +2611,8 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
> > >  static int rx_alloc_buffers(MGSLPC_INFO *info)
> > >  {
> > >  	/* each buffer has header and data */
> > > -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > > +	info->rx_buf_size = max(offsetof(typeof(RXBUF), data) + 1, sizeof(RXBUF))
> > > +		+ info->max_frame_size;
> > 
> > It seems like there is an existing size bug here, and likely should be
> > fixed separately?
> > 
> > i.e. this was already allocating 1 byte "too much". I'd expect this
> > first:
> > 
> > -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > +	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;
> > 
> > and then the next patch:
> > 
> > -	char data[1];
> > +	char data[];
> > ...
> > -	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;
> > +	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > 
> > The above would induce a binary output change, and the second would not.
> > 
> > Though this results in what you had for the v2 patch (but I can't
> > believe it had no binary changes...)
> > 
> > -- 
> > Kees Cook
> 
> Hi Kees, Hi Andy, Thanks for taking the time to review this patch.
> 
> As both of you had similar points, I will reply them here.
> 
> The reasons why it had no binary changes was because of the combination
> of this 2 things:
> 
> 1) Existing padding - so sizeof(RXBUF) returned 8 bytes in both cases.
> 
> pahole -C RXBUF gcc/before/drivers/char/pcmcia/synclink_cs.ko
> typedef struct {
> 	int                        count;                /*     0     4 */
> 	unsigned char              status;               /*     4     1 */
> 	char                       data[1];              /*     5     1 */
> 
> 	/* size: 8, cachelines: 1, members: 3 */
> 	/* padding: 2 */
> 	/* last cacheline: 8 bytes */
> } RXBUF;
> 
> pahole -C RXBUF gcc/after/drivers/char/pcmcia/synclink_cs.ko
> typedef struct {
> 	int                        count;                /*     0     4 */
> 	unsigned char              status;               /*     4     1 */
> 	char                       data[];               /*     5     0 */
> 
> 	/* size: 8, cachelines: 1, members: 3 */
> 	/* padding: 3 */
> 	/* last cacheline: 8 bytes */
> } RXBUF;

Ah-ha, now I see.

> 
> 2) RXBUF (as implemented now) is just  like a pair of lenses from which a
> developer can have access to one of the circular buffers in MGSLPC_INFO
> struct called 'rx_buf'. 
> 
> 2611 static int rx_alloc_buffers(MGSLPC_INFO *info)
> 2612 {
> 2613         /* each buffer has header and data */
> 2614         info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> 2615
> 2616         /* calculate total allocation size for 8 buffers */
> 2617         info->rx_buf_total_size = info->rx_buf_size * 8;
> 2618
> 2619         /* limit total allocated memory */
> 2620         if (info->rx_buf_total_size > 0x10000)
> 2621                 info->rx_buf_total_size = 0x10000;
> 2622
> 2623         /* calculate number of buffers */
> 2624         info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
> 2625
> 2626         info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
> 
> To be honest, char data[_1_] in RXBUF was never required to be there.
> The code base seems to make sure that it doesn't run past its limits by
> keeping track of size buffer on MGSLPC_INFO->rx_buf_size (and sometimes
> RXBUF->count)
> 
> (Addressing one point made by Andy about using of of the macros in
> overflow.h)
> 	struct_size(buf, data, 1) would return 9 bytes which could
> 	potentially break the existing driver as it produces binary
> 	changes.

Yeah, I think your v2 is fine. Perhaps explicitly repeat the notes about
struct size padding in a v3 commit log?

-- 
Kees Cook
