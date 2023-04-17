Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3906E4C59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDQPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:04:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4619A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:04:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so11857755wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681743869; x=1684335869;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r289gp/zTqEKyD+xyIg8Q8UOxcZRtz7DHOB0I75vTG8=;
        b=cAvnOsdoix6d8t7QMzHIiWPB6xAJyYE11peuEko54zFQduh6mUzEVC0JabN1NFJM7x
         zQ9faT8q/ASPquFaIqNpcjUmldYanm3GRlX62CINGX/qcZlZSBkQ+Thaeg9JWGKDrZ68
         oJBUu1tr5U/WKhZMLhWYZ2tLr9y/lrwR6dLvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743869; x=1684335869;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r289gp/zTqEKyD+xyIg8Q8UOxcZRtz7DHOB0I75vTG8=;
        b=Mx+9diGpfQKZDyeXC2Ev1wykFZEKwzyYycZF6xQ53eISCBqMPOje/vT2oohz9iIHDH
         jUSFZaAM/ETiLk7lQganxJ09wjnmbQtZ9OkZ+R8hiZeK7d7GSHOXzxFGIOFBO+nJ1OEa
         EtpzMl0goYBFhFuyIJZyZ952IuOUzP9KhMNT6MpQRi/ilZI0v2FsO1mOHP02iTP1871J
         M3CbJYA0epak3vDMu19FWVEcvPHyeOHTlHKUhgCr3IzvIeC5DhzFnPWt3m4/iSUKWi4L
         61Ytot/QPpFtRCmAm15WUgUL4Y3TvmF1MJSwZpEPa1rQQ6Ze6YALMkqyADSi1uto12+N
         /h3Q==
X-Gm-Message-State: AAQBX9cyRwUSpsh9LReOLucrDjHiJdFefyHILggy6TAM36GhQ7UsJz76
        8mcmWZc4k2XB9KVyjpAFuNjIlw==
X-Google-Smtp-Source: AKy350ZnbxLV0c4ion0MZAkmicpqZPcCi4ri+dJijWoniIXyjGyRQQt11+M59qq9dM5vxV47z+hm9g==
X-Received: by 2002:a1c:4b04:0:b0:3ed:4b0f:5378 with SMTP id y4-20020a1c4b04000000b003ed4b0f5378mr10808591wma.27.1681743869556;
        Mon, 17 Apr 2023 08:04:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003f173987ec2sm3243185wms.22.2023.04.17.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:04:28 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:04:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <ZD1f-1JjpihR1djd@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yw80MmyBl4js09If@alley>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(To others on this thread wondering about this patchset, Petr and I have had 
some discussions offlist about v4 and it should be up soon.)

Petr Mladek writes:
>I thought a lot how to do it a clean way. IMHO, it would be great to
>parse everything at a single place but it might require updating
>all drivers. I am not sure if it is worth it.
>
>So, I suggest to do it another way. We could implement a generic
>function to find in the new key[:value] format. It would check
>if the given option (key) exists and read the optional value.
>
>The optional value would allow to define another new options
>that would not need any value, e.g. "kthread" or "atomic" that
>might be used in the upcoming code that allows to offload
>console handling to kthreads.

Any thoughts on something simple like this that takes advantage of memmove()? 
This should overcome the mmio/io concerns, and it's fairly simple.

---

static bool find_and_remove_console_option(char *buf, size_t size,
					   const char *wanted, char *options)
{
	bool found = false, first = true;
	char *item, *opt = options;

	while ((item = strsep(&opt, ","))) {
		char *key = item, *value;

		value = strchr(item, ':');
		if (value)
			*(value++) = '\0';

		if (strcmp(key, wanted) == 0) {
			found = true;
			if (value) {
				if (strlen(value) > size - 1) {
					pr_warn("Can't copy console option value for %s:%s: not enough space (%zu)\n",
						key, value, size);
					found = false;
				} else {
					strscpy(buf, value, size);
				}
			} else
				*buf = '\0';
		}

		if (!found && opt)
			*(opt - 1) = ',';
		if (!found && value)
			*(value - 1) = ':';
		if (!first)
			*(item - 1) = ',';

		if (found)
			break;

		first = false;
	}

	if (found) {
		if (opt)
			memmove(item, opt, strlen(opt) + 1);
		else if (first)
			*item = '\0';
		else
			*--item = '\0';
	}

	return found;
}
