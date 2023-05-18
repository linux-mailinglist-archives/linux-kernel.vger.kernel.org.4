Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0A708885
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjERTmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjERTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:42:33 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED79E6D;
        Thu, 18 May 2023 12:42:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 51F9E6018D;
        Thu, 18 May 2023 21:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684438948; bh=8TuUr/tbhWxw/Wl+c1CUiJnNsg4NRh0wA3s+nfMW4/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ULkr652diD3aZMEl8lIMDS5dVWGd0asdy7dR+2X7PL5Qonso9mzYF+yprshQCNiGq
         X98B2Jo8FKpyKP3lu2F6CPzJtC5ilcZX+fz1Z0A57CQEC/JeUIAasCdb38AF0AkqTb
         H/kNQHegJs+EZ/Bmy4WO8Hzz+vgHRzt2Q289h/ip4PXUMG0YdQ2V33Ram1bsT2CAgS
         CP8iFXJ5hGzNUDiydEx2CR4+VGlq+/GqxrZA1oIZy4qgiuBpTsm11h19Urv/369tKv
         mYeYfMaLzwwfvWH18d6OlEOw9els5HJPvpJ5t7PRo9s5ZSXAlg5lLkJmsP8069t5eH
         KGDna0oltbX7Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tzS0IgwIkEhc; Thu, 18 May 2023 21:42:25 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id EDFA760189;
        Thu, 18 May 2023 21:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684438945; bh=8TuUr/tbhWxw/Wl+c1CUiJnNsg4NRh0wA3s+nfMW4/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EGTcjHmIDggZ8hor6P64XQL/UpBQoNU9/LBm/5CrxLwXPmQXQhS8rKlO2TseY/GDF
         AY7u7syczZeCtxmS94m6DLjB17y5QUeZfucAvgyCasxw4yH7hF/m6b9xvuYHHjBmPx
         C8LBSQ6FAYruE6sR4x5TIqmRyf8dAaqJU7vt749tGtMlGC1+rLomkj0UGqadAn3qxS
         KbZUR3/b+/d0zL9T/rf1d8dmlNp3lywYsQJ4jPna1+VAht61NIIntoEzXCmPx787VU
         ui5YPEosZF0dfGwYF/wOOwQ/lMHadnOLQqEEuRv99Aijl/3g3YUMEFaXd/K9Ns1N6i
         gxKbdKctE6bbw==
Message-ID: <bd373477-79eb-a178-b3c4-1f7699689fbb@alu.unizg.hr>
Date:   Thu, 18 May 2023 21:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] driver core: class: properly reference count
 class_dev_iter()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <2023051610-stove-condense-9a77@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023051610-stove-condense-9a77@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 21:20, Greg Kroah-Hartman wrote:
> When class_dev_iter is initialized, the reference count for the subsys
> private structure is incremented, but never decremented, causing a
> memory leak over time.  To resolve this, save off a pointer to the
> internal structure into the class_dev_iter structure and then when the
> iterator is finished, drop the reference count.
> 
> Reported-and-tested-by: syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi, Greg,

Did I forget to give the

Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

I apologise if I did.

Best regards,
Mirsad

> ---
>   drivers/base/class.c         | 2 ++
>   include/linux/device/class.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index ac1808d1a2e8..05d9df90f621 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -320,6 +320,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
>   		start_knode = &start->p->knode_class;
>   	klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
>   	iter->type = type;
> +	iter->sp = sp;
>   }
>   EXPORT_SYMBOL_GPL(class_dev_iter_init);
>   
> @@ -361,6 +362,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_next);
>   void class_dev_iter_exit(struct class_dev_iter *iter)
>   {
>   	klist_iter_exit(&iter->ki);
> +	subsys_put(iter->sp);
>   }
>   EXPORT_SYMBOL_GPL(class_dev_iter_exit);
>   
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 9deeaeb457bb..abf3d3bfb6fe 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -74,6 +74,7 @@ struct class {
>   struct class_dev_iter {
>   	struct klist_iter		ki;
>   	const struct device_type	*type;
> +	struct subsys_private		*sp;
>   };
>   
>   int __must_check class_register(const struct class *class);
