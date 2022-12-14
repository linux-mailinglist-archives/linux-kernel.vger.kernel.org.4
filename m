Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05F564D138
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLNUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLNUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:31:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FD53ED6;
        Wed, 14 Dec 2022 12:20:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id js9so8188101pjb.2;
        Wed, 14 Dec 2022 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCMuwp6GHgx/gJjEvxb/mxRR0z43kVs2zMyGQJ7ZUao=;
        b=AQLztXK1M1qpPDgvPdbon4vR2HPGNB1ixFvO2/yz7mYIcNQUkP4VB8nDMKJ1MDUHny
         KRfaA1kWY1m9vCttGMDGCvr987BlUkF7z5vsZVOEhUNE/ipFMbjCWOeJevCM8BRSlvnF
         /uoCeMieK2qUfkQe/cf9pKw7B7dbtCIscRX3KfW8tpIwJi+j+9Ua3j24IGoWrbNbeZyp
         lsGbD4P7Mi3Gzw7ng0QCHRFM0FaV2eTk6B1Zgp+pn8Z/F9wcUkh6+Rhh3vhtlOhDYSe4
         WJHV9AueDIql8WMy/ete+n9+jA9JhTm20u6JY1Ms5KBbbSLsNAtlmX4Er3ignpT7+EO8
         e/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCMuwp6GHgx/gJjEvxb/mxRR0z43kVs2zMyGQJ7ZUao=;
        b=oU3NNl/pXAQMeaEq0+8aO7p0yN+UjloZAwLpnUg4LYUlmP6AOnlfx/+GOhSPbhDL7t
         aQgsp2fQ9/dZkFz0E1gpDv5oBZkrFqDEF5tEtZ5i5E/rjXodL1eFkLuRf01qUV25If7z
         pIP2CHaVJDFK8ikPYwTTitcECL4HLTg6iWCtJ1/XYJx5PSCnlHRFtZch4hM7v2KjecQR
         GvFcf0UYWQEIB98KhZVE4uX/Rmi13HEJ3QDmKEUsbAZyvZ/GckD1FFdxH8R0k2VQlBOf
         NLBTbiN9GKfrK3PDlZWqf+RRMCELn2JkxZzwnyOxUmzm/bzL0BqQkv8vlH84km2pFUXd
         Zxiw==
X-Gm-Message-State: ANoB5pmQgl7PIWhDfSIgHv/mIWI7VXendu2zSaH6eWIQEUidoQs3Q1UC
        0FQ86XCb2gz888Zn1AdHpbE=
X-Google-Smtp-Source: AA0mqf4Jsc2fjFSItEtwphKipl2TY//QD0Mh80VZfcRorAkD8vYu2Vbs2W8MwLmkec5JO29/RJjG4g==
X-Received: by 2002:a17:902:bf47:b0:189:e904:c831 with SMTP id u7-20020a170902bf4700b00189e904c831mr6529639pls.3.1671049204468;
        Wed, 14 Dec 2022 12:20:04 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b00189a50d2a38sm2283486pln.38.2022.12.14.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:20:04 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:19:57 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: Re: [PATCH v2] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
Message-ID: <Y5ov7fgIX4IICSSq@mail.google.com>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <Y5mQTOqFOGbJMerV@mail.google.com>
 <CAHp75Vd914H7swqqqydSLYOJh-4=+rWNCUdqizaQQxmVtpiMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd914H7swqqqydSLYOJh-4=+rWNCUdqizaQQxmVtpiMSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:43:48PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 14, 2022 at 10:58 AM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct RXBUF. No changes were required
> > within the source code because of the existing padding in RXBUF struct
> 
> You shouldn't rely on padding. Make you change robust independently on
> the padding. See also below.
> 
> > It's worth mentioning that doing a build before/after this patch
> > results in no binary output differences.
> 
> This is interesting...
> 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> >
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> >
> 
> The blank lines are not allowed in the tag block (in case you want to
> have Link: to be recognized as a tag).
> 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Changelog:
> >
> > - v2: removed changes to how the size of RXBUF was calculated. I
> >   changed my mind after thinking about the existing padding in the
> >   struct. Happy to discuss it if anyone sees it differently.
> 
> I feel worried about in particular this code:
> 
> /* each buffer has header and data */
> info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> 
> which means that entire rx_alloc_buffers() should be revisited. Also
> take into account the use of one or more macros from overflow.h for
> memory allocation.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Hi Kees, Hi Andy, Thanks for taking the time to review this patch.

As both of you had similar points, I will reply them here.

The reasons why it had no binary changes was because of the combination
of this 2 things:

1) Existing padding - so sizeof(RXBUF) returned 8 bytes in both cases.

pahole -C RXBUF gcc/before/drivers/char/pcmcia/synclink_cs.ko
typedef struct {
        int                        count;                /*     0     4 */
        unsigned char              status;               /*     4     1 */
        char                       data[1];              /*     5     1 */

        /* size: 8, cachelines: 1, members: 3 */
        /* padding: 2 */
        /* last cacheline: 8 bytes */
} RXBUF;

pahole -C RXBUF gcc/after/drivers/char/pcmcia/synclink_cs.ko
typedef struct {
        int                        count;                /*     0     4 */
        unsigned char              status;               /*     4     1 */
        char                       data[];               /*     5     0 */

        /* size: 8, cachelines: 1, members: 3 */
        /* padding: 3 */
        /* last cacheline: 8 bytes */
} RXBUF;

2) RXBUF (as implemented now) is just  like a pair of lenses from which a
developer can have access to one of the circular buffers in MGSLPC_INFO
struct called 'rx_buf'.

2611 static int rx_alloc_buffers(MGSLPC_INFO *info)
2612 {
2613         /* each buffer has header and data */
2614         info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
2615
2616         /* calculate total allocation size for 8 buffers */
2617         info->rx_buf_total_size = info->rx_buf_size * 8;
2618
2619         /* limit total allocated memory */
2620         if (info->rx_buf_total_size > 0x10000)
2621                 info->rx_buf_total_size = 0x10000;
2622
2623         /* calculate number of buffers */
2624         info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
2625
2626         info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);

To be honest, char data[_1_] in RXBUF was never required to be there.
The code base seems to make sure that it doesn't run past its limits by
keeping track of size buffer on MGSLPC_INFO->rx_buf_size (and sometimes
RXBUF->count)

(Addressing one point made by Andy about using of of the macros in
overflow.h)
        struct_size(buf, data, 1) would return 9 bytes which could
        potentially break the existing driver as it produces binary
        changes.

Let me know your thoughts

thanks!

- Paulo A.
