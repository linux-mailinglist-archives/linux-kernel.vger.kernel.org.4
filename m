Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08983746B52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGDH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00769E52
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+z65LvmorUornhZW4Ei6pDZqxls4YGQhYkabgi/Fgo=;
        b=ci+glooc0TZVNvX45QBbEZjz5t6Pfn2gwdEOTSBin1sAmxu1sszjU+Zrd9K5fi0SPReFz1
        FGxum1TBG8r7yc68RUwPPsAgwe04RWi/9n3ojucHCoc1N6Sm0lpKqv3gEqaH9+06PFmtKA
        WVUvTD93XGzh2hvfIRkd1zyLslJJ3A0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Weg6cSr9MbON8EXK67tVyA-1; Tue, 04 Jul 2023 03:58:04 -0400
X-MC-Unique: Weg6cSr9MbON8EXK67tVyA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6ef65eaadso9928281fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457482; x=1691049482;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+z65LvmorUornhZW4Ei6pDZqxls4YGQhYkabgi/Fgo=;
        b=dhPAgHM55OrOxfgGv+GuwUg1TxwJYpkLm6ZqE693L8GDA+0eNgUzWzjl5guwBziFLA
         +ehLt7brg+aGp6Mogc9196wF+noo13MSO3RAzguDhX8vINfTFr3cMBJ7GnBi00hEfptL
         ubRUeLrIHL7jfMSzvvEqDzNdyoP4QQzNrlRf7lzI7cn0hIcfPigo122BeasxlOWpolc0
         ijMjnvntOEkGPkslNhq6KOM28kKDA0EnvD3jTXlUbQGCQ2bohP7jpp5SSgkZF08uz0Xh
         aQBMy+ocXLlb8AGEpCDiQT3Ml10Pl8icCfOswnW5Y52fs1UStrAVgxtIYNTcKi/0+bP3
         auRA==
X-Gm-Message-State: ABy/qLZEnzXUBKLgyRoLPXYfP+wdC0DcxRFXiEK4GyO7CtioN/Da7W+n
        qUf+9FTJFYkPxPTAs7+8yYK3ikm3zeUNzqkrRctV8nbgCZ427RHQc1Ak4f1JwyVJi7jtmLe4TTZ
        RCTId7DaNiPBAu6Wix5NgY3Mw
X-Received: by 2002:a2e:9159:0:b0:2b4:78f6:d335 with SMTP id q25-20020a2e9159000000b002b478f6d335mr9686694ljg.8.1688457482306;
        Tue, 04 Jul 2023 00:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGP5ieUAuoHkl1LDfFH6zWVviU5R2QJOtqbelgfD+Ggwr/XJ6o+iJfxnnHrp7TPWS1RTCoQZA==
X-Received: by 2002:a2e:9159:0:b0:2b4:78f6:d335 with SMTP id q25-20020a2e9159000000b002b478f6d335mr9686681ljg.8.1688457482001;
        Tue, 04 Jul 2023 00:58:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm22874960wma.21.2023.07.04.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:58:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] fbdev: Move core fbdev symbols to a separate
 Kconfig file
In-Reply-To: <ZKPHmJDsUtG7nROo@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-3-javierm@redhat.com>
 <ZKPHmJDsUtG7nROo@smile.fi.intel.com>
Date:   Tue, 04 Jul 2023 09:58:00 +0200
Message-ID: <87bkgsyupj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Jul 04, 2023 at 01:05:26AM +0200, Javier Martinez Canillas wrote:
>> The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
>> core fbdev symbols, that can be enabled independently of the fbdev drivers.
>> 
>> Split the Kconfig in two, one that only has the symbols for fbdev drivers
>> and another one that contains the fbdev core symbols.
>
> ...
>
>>  source "drivers/video/fbdev/omap/Kconfig"
>>  source "drivers/video/fbdev/omap2/Kconfig"
>>  source "drivers/video/fbdev/mmp/Kconfig"
>> +
>> +source "drivers/video/fbdev/core/Kconfig"
>
> Hmm... Shan't we start Kconfig from core options?
>

I added after the drivers because Geert said that preferred that way
(unless I misunderstood him from our conversations in IRC).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

