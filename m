Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3173F3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0FSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0FSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:18:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F30E74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:18:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991fee3a6b1so100486866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687843095; x=1690435095;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bBVB1M1DVcwwCY91EidRt2nOFBceyZs1OZG10lIfCXk=;
        b=k8dX1aeHrFFshxDnKcJX4En2Vtyeu5xdM33agtVZiN2/Xmay5kfzvLcdIsseO99ocP
         kT3nPI3orE/1WRDieqli47lmmVQc6RCCYbEkqeeNqrgXinsF49qQz6EsSAmUypcvXkqb
         hXQeoTb9fTceZLsZy4ZknAJynor8+BC0VznbGaiWz8d26uT+bi12074ztAzLBuOle2JG
         CC2Vr5sdydPg1lfGb/IU/LowHti7Sscti8dTbmESwC4E7R6pWEagZtrcm38Yopx+r1fS
         YxqknNlbZp11rjXd3XWSnERjMZLYq3x2iDX/ewl9b9r5RKRbu+aFAlXd5c1uloz3zMqM
         C/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687843095; x=1690435095;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBVB1M1DVcwwCY91EidRt2nOFBceyZs1OZG10lIfCXk=;
        b=F0ICrL4vZf7O7tfkz5SwuWtY2VEhqY1LZRqURP2DUwrdgLDwbuvFD6yvALEhS0ZzqD
         9MWxGycaWtm+FviOWv3Q0dW1jJy/k0FfwkOVyPa6u1SzbNF3lvBLaxe4wndPE39DlGbZ
         o9AYoVyHN3AW501PRpWU1/eq+E5X0R9EO1t1zv7OHoPIcPqW1jpnEAYIKEHxxREpxUQb
         WTt7gICChvtp1qxKmYkn+S3a+odkjuz2yGzSjbHeLDQNeJbU41aO6VD5wFCQrX2306WN
         LKhDrddDcNwW4GwBELpLDuazNMX99wcIYRcsS+fRvoI1SVGOHNuUXC8YamsbwuJYQtCV
         nnFQ==
X-Gm-Message-State: AC+VfDyp9ZJ4MCBUwabBQQUX0AOXMkQn6dmh9za/EJB6+lLbepMmTO81
        Oytis3lvMIyWgssNTUFuDkvcYA==
X-Google-Smtp-Source: ACHHUZ5lFFwK1USTTy3ZzCyqAjkCc5nd/YCwcDm2BO3sPlbGehbP63aPX+9FcDbCrAEZvDlccXRoug==
X-Received: by 2002:a17:907:360e:b0:96a:4ea0:a1e7 with SMTP id bk14-20020a170907360e00b0096a4ea0a1e7mr29909752ejc.50.1687843095228;
        Mon, 26 Jun 2023 22:18:15 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090646cd00b009889c4bd8absm4030395ejs.216.2023.06.26.22.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:18:14 -0700 (PDT)
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <ZJpbUShJUL788r7u@infradead.org>
 <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        gost.dev@samsung.com, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Date:   Tue, 27 Jun 2023 07:14:58 +0200
In-reply-to: <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
Message-ID: <87mt0lh4a2.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 6/27/23 12:45, Christoph Hellwig wrote:
>> On Mon, Jun 26, 2023 at 06:47:52PM +0200, Andreas Hindborg wrote:
>>> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
>>>
>>> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes even if
>>> device `max_zone_append_sectors` is zero. This will cause the IO to fail as the
>>> io vector is truncated to zero. It also causes a call to
>>> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is probably
>>> not intentional. Thus, do not use append when device does not support it.
>> 
>> How do you even manage to hit this code?  Zone Append is a mandatory
>> feature and driver need to check it is available.
>
> ublk driver probably is missing that check ? I have not looked at the code for
> zone support.
>
> But thinking of it, we probably would be better off having a generic check for
> "q->limits.max_zone_append_sectors != 0" in blk_revalidate_disk_zones().

I was playing with ublk zone support. It seems I made it buggy by
allowing zone append size to go to zero.

Adding the check would be a nice help to people like me that will
implement whatever in their driver :)

Best regards
Andreas
