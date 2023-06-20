Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C32736304
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFTFJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTFJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:09:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0E1A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:09:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3112902f785so2435643f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687237748; x=1689829748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKvf9RKheTlL+7tVB2AlP18M/WC4u+fPZRhsq8KfuhM=;
        b=YVA/znGG2aHxgXOEPH+jwK51aajy1Z464uJ/1tzbY4Gpc2+C61HM6jKkT2BdNh+4/R
         +w9BxuJQskfjzgibeWAe6743EgEBD0ZjeEjBt84iAyRrkmtZ/lvF2xjMmXedlquszMKE
         jPRJhASdq3yTmLK9FsCYfsFzBSPabE8+F5y6NHxTB+QxHtkIgdNpC7zIxWSOmRHrYCtK
         G0Jxk3WdqYtuX+FliFvE57QGc2qPM0SLhP2oxbKeXVguy4IeOLHWnPX4cwM857MX6BgI
         pX+nPA0RFaNYLu+aX8IQfhyqaWhlUzQM1tfcMXeXHMUZDXTaBr1+nHPQ/etL5oWJXIEz
         al2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687237748; x=1689829748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKvf9RKheTlL+7tVB2AlP18M/WC4u+fPZRhsq8KfuhM=;
        b=ThHuQ5LQ6uehdZEPx8MPTxCrHwSWShZVl7xLIX4p+dtyegBUjUSO4h2rgMpu8rmzCC
         wUmR9rUFqvqVxfUjp2b5FZWHwRXB5c+K+0jdxfz9pL9BDS5PAJh3psRYY+uyKqPmjJUx
         aRQugkN5VxOXcl1ljhh8mDRSZ+3/qsurVTUQcjJeX0kljhzxrohLtCOSFbFiVPWn/k83
         jnYVv8s9ffDNsAxX1IL5MLCatbMW1yYinAKJB0UmTOLVnYcE4eJ5fnNBnOT0hPbme6o3
         9uLqKRD3ZAJsJ4wqF+4Tz2LQ0OxLlLpg/sgWLHbDWrjCQ7QmmTPss60/wv8cfPPNVSJj
         MSig==
X-Gm-Message-State: AC+VfDw1D6+Bkc8iZIV6eiKsmCDJoLvsmMf0AGnwFKvhrXSh4ujTCIPl
        dI8hD9RjxvSz6rS7isMauQRlYA==
X-Google-Smtp-Source: ACHHUZ5bIPCqREsfsDXa8tW1mSMoj8KpdzN4T/+vMC5+V+j5G5nSHLp/OPLBEtG4ocyoEO527nlaGw==
X-Received: by 2002:adf:e403:0:b0:311:10ae:123e with SMTP id g3-20020adfe403000000b0031110ae123emr10340500wrm.2.1687237748405;
        Mon, 19 Jun 2023 22:09:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b10-20020adff24a000000b0030ae901bc54sm1060989wrp.62.2023.06.19.22.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:09:06 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:09:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: Reorder fields in 'struct hid_field'
Message-ID: <658cf2e3-3da7-4dbd-977e-4722f52cd63f@kadam.mountain>
References: <a804f2e91bc32cc5e17e012ed90972415606db4e.1687075665.git.christophe.jaillet@wanadoo.fr>
 <d6026b7f-dc07-4d0c-9805-cc61d6b9a4b8@kadam.mountain>
 <ba1a74ba-e91a-bf12-2d4e-7157e4519478@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba1a74ba-e91a-bf12-2d4e-7157e4519478@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 08:20:08PM +0200, Christophe JAILLET wrote:
> Le 19/06/2023 à 07:18, Dan Carpenter a écrit :
> > On Sun, Jun 18, 2023 at 10:08:07AM +0200, Christophe JAILLET wrote:
> > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > index 39e21e3815ad..5be5e671c263 100644
> > > --- a/include/linux/hid.h
> > > +++ b/include/linux/hid.h
> > > @@ -480,9 +480,9 @@ struct hid_field {
> > >   	__s32     physical_maximum;
> > >   	__s32     unit_exponent;
> > >   	unsigned  unit;
> > > -	bool      ignored;		/* this field is ignored in this event */
> > >   	struct hid_report *report;	/* associated report */
> > >   	unsigned index;			/* index into report->field[] */
> > > +	bool      ignored;		/* this field is ignored in this event */
> > >   	/* hidinput data */
> > >   	struct hid_input *hidinput;	/* associated input structure */
> > >   	__u16 dpad;			/* dpad input code */
> > 
> > You could move the dpad next to the ignored to save another 4 bytes.
> > I think it is still grouped logically that way but I don't really know
> > what dpad is so I might be wrong.
> > 
> >    	struct hid_report *report;	/* associated report */
> >    	unsigned index;			/* index into report->field[] */
> > 	bool      ignored;		/* this field is ignored in this event */
> >   	/* hidinput data */
> >    	__u16 dpad;			/* dpad input code */
> >    	struct hid_input *hidinput;	/* associated input structure */
> > 
> > regards,
> > dan carpenter
> > 
> > 
> 
> In fact, not really,
> It would fill a hole better, but would generate some padding at the end of
> the struct:
> 
> 	bool                       ignored;              /*   108     1 */
> 
> 	/* XXX 1 byte hole, try to pack */
> 
> 	__u16                      dpad;                 /*   110     2 */
> 	struct hid_input *         hidinput;             /*   112     8 */
> 	unsigned int               slot_idx;             /*   120     4 */
> 
> 	/* size: 128, cachelines: 2, members: 25 */
> 	/* sum members: 119, holes: 2, sum holes: 5 */
> 	/* padding: 4 */
> };

Ah.  Right.  I should have looked at that more closely.

regards,
dan carpenter

