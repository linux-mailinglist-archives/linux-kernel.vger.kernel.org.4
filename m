Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDC7008A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjELNJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjELNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:09:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18FD07A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:09:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-306f2b42a86so6585070f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683896981; x=1686488981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMHC1baICqbV/7IIejzzefa+PcpliFHn4ViPUWBkzwk=;
        b=nWdKOyt2/UbR8Uu1VEhhE0dtqojxGY5VLr2j4rxfWqEYlyoMQiirm9eeUQUileh9yP
         0xe9zumAgOQSRTbDDV4nipBC7G9wiQkNrFwXSavhsfJjC37gfftYnUN6e0vOKa7KabnY
         PyXDE4TKxk5eVWjC8SOrRiCj6RN9wOluBZdhJxkHzDDssOMy3ZZrRaYmDHmDBGMGvnUn
         kxSDKf9u/omSXSkHcCvnq6pTQct7ws0uCsOBcZ6eB3Vxeim+9O5uFPl5yfMLsl8ZPSfE
         0SGrN2xJMPi9LepKp+FRZmwiQ25F5BrWXuocFamnMgXEkpIHeR97ZrpTNt1FMTuP8RGG
         xa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896981; x=1686488981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMHC1baICqbV/7IIejzzefa+PcpliFHn4ViPUWBkzwk=;
        b=i3avmVKbwzH/OwPXpZybxOvitopXinNVSEo4hHwT1VMU6/egf1h/LmUx6r3/aOgl2L
         NO5/Ljyp0swC0wXJDva5AdGP2N/5i/Z0W1AD/mLbR2ioXFP+vyuVusacBxXnRqJwV1Cl
         b90XnpQqM/R2DiLiGHkyoQ0wBVgOwYW5t5b4hAYY9cOUghraO4nS5F3ZyA8M2ZO8bzAT
         DUdHQtKl5zZKYihS2IeizPzxqV5NCzD9y0n6ORFKU1FdtGRv8oBiQ0UtSOT+VSJqZ0ea
         owY5vSEQ4EgppEr2VajEbbHiKIQ3/gBTfEiKpRPiBi2k8Idihq/adm9ufT8TI+szPRFk
         N5qA==
X-Gm-Message-State: AC+VfDwpBzTr3zxnOHUr2YvKCHsYNCoaK9KSwlo77UHgQLovGn9Ox952
        RbsSk0lK2zCP/XcY09vY93B9u+R1Q6/P/Z76KI4=
X-Google-Smtp-Source: ACHHUZ59NczSqJnrxH1ndGi0y5Kc1/VmRGX7UGYYwolAm1YtFlu/EuyXwbF2gyTqfu3MM6wlfkq55A==
X-Received: by 2002:adf:e84e:0:b0:306:35fa:202b with SMTP id d14-20020adfe84e000000b0030635fa202bmr16017563wrn.6.1683896980871;
        Fri, 12 May 2023 06:09:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d58c1000000b00306c5900c10sm23226447wrf.9.2023.05.12.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:09:39 -0700 (PDT)
Date:   Fri, 12 May 2023 16:09:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
Message-ID: <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
 <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
 <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
> > @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
> >   	mutex_lock(&test_fw_mutex);
> > +	if (test_fw_config->reqs) {
> > +		rc = -EBUSY;
> > +		goto out_bail;
> > +	}
> > +
> >   	test_fw_config->reqs =
> >   		vzalloc(array3_size(sizeof(struct test_batched_req),
> >   				    test_fw_config->num_requests, 2));
> 
> I was just thinking, since returning -EBUSY for the case of already allocated
> test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
> to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
> understood well, the CoC requires that I am explicitly approved of those?
> 

If everyone else is okay, let's just apply this as-is.  You did all the
hard bits.

regards,
dan carpenter

