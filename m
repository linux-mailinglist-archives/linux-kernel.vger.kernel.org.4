Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888B15B5C54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiILOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiILOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:37:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F342222B6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:37:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so12552433pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CpzuIbNJ8KEdKpTsfsFC0v9WS/vo0DOAwr19c0IuV2g=;
        b=QQX1+0QsF9vc8k2cmkn796NqgHxnh9hHihIS152Lauz4xX6Xafz/EBsmP3I9x7A1fx
         ijedjcuneCOvmAPPCZ0g5uMhdeCuqktQC1+2sZMYPdSSmIMoAdk5Pz5p+FJfYRKTy+sc
         JYI8zcXG23fEU4NP+CS3JwU5vFYBgLdjmnVy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CpzuIbNJ8KEdKpTsfsFC0v9WS/vo0DOAwr19c0IuV2g=;
        b=OBMNPyxhJ06IaVO7DW10ACbiKrNKn+NyfSlH+o4cIC4PdHC2kZgZ1OCNBdAJhAsiUe
         jGe6SnaWbxgFo+FiAnaIofzHcFi9dSQh5sIhT1OYGZpjdClAOChuagxM8pDYrEqj0Ydz
         uKl46idEEPXi388zh8z0ogeu/YMzCQ4jGg6+LTNlJka3LD2nmoCvRPZ5zhOvHFgcyF6y
         /uQgmPHhQaIFvHFLfJNlo7BXFCKRw5ueEmPsgJyEWPD2NI5CPdq8iwdiguJbrLJ0pkw2
         Cn9Ci4uDRwSfUGdwcXn2SYO380+/3llDd48umZVI5DlRuDjTDYQZnxlsx26NzzbV46p6
         U+/g==
X-Gm-Message-State: ACgBeo3OZce0TfDvq0W64AV6+pwa2Hmpv/qoAoMeNO1xYIbC1YHnnt8F
        RypQ+za+ASOi7BMDSaIUxCbqsw==
X-Google-Smtp-Source: AA6agR7atuOV8oIRurU0P/NDqF37/hyYybcfK73M3+gwGcWvy8JmnFCJM3LHSVYHdWeUojbQtpIxeQ==
X-Received: by 2002:a17:90a:fe90:b0:202:a345:b7a6 with SMTP id co16-20020a17090afe9000b00202a345b7a6mr6609263pjb.14.1662993462959;
        Mon, 12 Sep 2022 07:37:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:481a:bead:f512:e554])
        by smtp.gmail.com with ESMTPSA id h6-20020aa796c6000000b0053e22fc5b4fsm5631299pfq.0.2022.09.12.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:37:42 -0700 (PDT)
Date:   Mon, 12 Sep 2022 23:37:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] zram: do not waste zram_table_entry flags bits
Message-ID: <Yx9EMhwLXnDYlQwd@google.com>
References: <20220912053755.156704-1-senozhatsky@chromium.org>
 <CADyq12yWFMyTRCQmmGoLg7epvXRWu-XqKMS4N2vEomvvuWNpBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12yWFMyTRCQmmGoLg7epvXRWu-XqKMS4N2vEomvvuWNpBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/12 10:20), Brian Geffon wrote:
> >  /*
> > - * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
> > - * object size (excluding header), the higher bits is for
> > - * zram_pageflags.
> > - *
> > - * zram is mainly used for memory efficiency so we want to keep memory
> > - * footprint small so we can squeeze size and flags into a field.
> > + * ZRAM is mainly used for memory efficiency so we want to keep memory
> > + * footprint small and thus squeeze size and flags into a flags member.
> >   * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
> > - * the higher bits is for zram_pageflags.
> > + * which cannot be larger than PAGE_SIZE (requiring PAGE_SHIFT bits),
> > + * the higher bits are for zram_pageflags.
> >   */
> > -#define ZRAM_FLAG_SHIFT 24
> > +#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
> 
> Why not just hard code 16 with an explanation that it cannot be
> increased further using the analysis you did in the other thread? It's
> going to be tricky to reason about how many free flag bits actually
> remain with PAGE_SHIFT across all architectures, especially given we
> have no architecture specific flags.

Well, zram should not make any assumptions on arch code. How do
we know that PAGE_SHIFT 16 is the max value we will ever have?
Some arch can come around someday and use PAGE_SHIFT say, 18,
and we won't be aware of it (using hardcoded value of 16) until
someone hits a really hard to debug problem in zram.
