Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887470F5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjEXLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:51:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D22135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:51:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f1411e8111so832354e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684929091; x=1687521091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvUgAiVcia693kIUClLrrqIlm3JaNHdyav0slu5eGMo=;
        b=Uxj3xXgGnT30AuMcmLrKrrEH5nvwD2JZzKwg55Oah9UjaPnmaZ8+obVXreoQGkd1db
         cgh44MEZMQp3Ie9DLMiJFfO73UDMbY/3bVjxxInbGXlFeBptP/nd+mMv2DBwFm5CdrxS
         +0aHm8ZXe296v4jlNaSdABStyefNYJt+fKTtCjlEqbdGQMT3KfL/NWcKJihaOOUoJKVw
         vPAfwhaPIXQJBlzXLJtLPnM9jHstl4KPoTSlceryQ08vm3zxv1G5GqicsnroCrvfkO9+
         RsuQwyBX3ftJ5dHMCFT4D6/1JhA9czj9VWJmmsE1U3Sv+Cmz2QnDJ9OuTxPXaPB4Vzdy
         4WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929091; x=1687521091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvUgAiVcia693kIUClLrrqIlm3JaNHdyav0slu5eGMo=;
        b=MqkVZJ0z/GZJKkhrguvm5oLj2JW+VmtbTkAPKhqy9bVKGrPofzs1ApmSA5PT8OekKo
         PV/3x1Pk7A2HmKU3V6LUTzOwQAVNWKEGrrfxrrjjIPhSyS29962c81ZCV1LKglCT0o5o
         ACNT37bKS0uJps0I/mGfC4Fv1HfRrzwEpGJjvdEVqTYnRuSYbWK7Qs+svavBrnULbI2f
         PA+8hwIWDbV8Rj4tMRtBVz/F0tiU6EINuQC9+o0vWD/a9w9u+tONWOnqg0Q+/7aSL5iW
         HOJ2NCX+14E3B6u2nyctzE5LoGUMPqJMcwg5sutKvPHF+7n7lemENrQvWBk3FF9z9WU6
         fLcQ==
X-Gm-Message-State: AC+VfDz8uy+EsTx2An9zF8beIr+I9EIwMYSs+ju3vYzZ2slTnq+roovu
        qp84etBwZ7SXLj3mK+74Y+8=
X-Google-Smtp-Source: ACHHUZ4YO6KydrlqOjZzVkw80x8WD00C5pF74fH56kjKmcRPV0kbT3Tt0vZ+jtgPmNTQ6h7jAwPcdg==
X-Received: by 2002:ac2:4c8c:0:b0:4f4:af2c:97e with SMTP id d12-20020ac24c8c000000b004f4af2c097emr3065261lfl.11.1684929090720;
        Wed, 24 May 2023 04:51:30 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25329000000b004eca2b8b6bdsm1692804lfh.4.2023.05.24.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 04:51:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 24 May 2023 13:51:28 +0200
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <ZG36QNx2TbLq3oxT@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
 <20230523172409.goshjwenknthrbr4@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523172409.goshjwenknthrbr4@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 01:24:09PM -0400, Liam R. Howlett wrote:
> * Uladzislau Rezki (Sony) <urezki@gmail.com> [230522 07:09]:
> > This patch renames the adjust_va_to_fit_type() function
> > to a shorter variant and more expressive. A new name is
> > va_clip().
> > 
> > There is no a functional change as a result of this patch.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 409285b68a67..5f900efec6a9 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1383,9 +1383,9 @@ classify_va_fit_type(struct vmap_area *va,
> >  }
> >  
> >  static __always_inline int
> > -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > -		      struct vmap_area *va, unsigned long nva_start_addr,
> > -		      unsigned long size)
> > +va_clip(struct rb_root *root, struct list_head *head,
> > +	struct vmap_area *va, unsigned long nva_start_addr,
> > +	unsigned long size)
> >  {
> >  	struct vmap_area *lva = NULL;
> >  	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
> > @@ -1501,7 +1501,7 @@ va_alloc(struct vmap_area *va,
> >  		return vend;
> >  
> >  	/* Update the free vmap_area. */
> > -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > +	ret = va_clip(root, head, va, nva_start_addr, size);
> >  	if (WARN_ON_ONCE(ret))
> 
> ret is only used in this WARN_ON_ONCE() check (from patch 1), since you
> have shortened adjust_va_to_fit_type(), you can probably drop the ret
> variable all together here?
> 
I can move the WARN_ON_ONCE() check into the va_clip(). So it makes sense.

As for a return value, we should check it, at least here:

		ret = va_clip(&free_vmap_area_root,
			&free_vmap_area_list, va, start, size);
		if (WARN_ON_ONCE(unlikely(ret)))
			/* It is a BUG(), but trigger recovery instead. */
			goto recovery;



i t can fail, though it rather goes toward almost zero%.

Thank you for looking at it, Liam!

--
Uladzuslau Rezki
