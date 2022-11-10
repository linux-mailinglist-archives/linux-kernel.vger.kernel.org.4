Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE5624960
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiKJS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiKJS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:28:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67454201A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:28:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5555194pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyEJGijKGBRJHY8r7nc7bYXa2EVX6TUxpc+vsYLGDTQ=;
        b=KSCzhYv5rC/MLvGBZuK2uuZYVUC2XfMablPSMJj0OOx05oE5OLwIAOYWaXt6nIeNRE
         bTQvyvkcrNfKv0TO6YrKbA75HPMIxes2Yd9eBH1Dped1wErMrqqCO75oJbIOxq4yCMiX
         6JoKyXJWzsfy5x2TQkUCZpoays/DQKIIsjo4bb6XguvXFFY/VUbSRSiQ+F61TByzjGpg
         vplSwASmouoqkYzwEMbDxmmsPWCd3RF1BMdabCTZVGWq5wH6V6oFIw6J7zkRSa0JCm0J
         C8yKHa1Ou4GUPjI7NxJ4WJOXx2L4JtDV+VW3GGhjpXTQ1agOFOgXCrrJMhXVtnUipDmx
         nJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyEJGijKGBRJHY8r7nc7bYXa2EVX6TUxpc+vsYLGDTQ=;
        b=pQiRyUpc8M6on390PHA03z/ZaCs0bXbiWKZ8vUWwyEge6qp0PDqPzemLZUnPMmMeyu
         kt0TuO5bjPeyPZ6cCLFzeJmXvSMasPqWOE0DTg5HzGXOqMvDu+9Zb94h05HMmSxKpAL1
         cN87XEaoiPH+QoKdEx3rc+VbRTkGTLtRLq8ogTL2tcTNYDzcg/46wuV8VJpptocWS62u
         Rj3RH6ptbpk7/m8a39QxYWU0OuAE7kG1eIaSwe1GwUhcOHKfele7BJnW4KD1nrY9p2d0
         0mdKCxsPPR3r+OI1L2dWeJPcd3QsvT2A1/yATvZmnvf5GIqjlrjkB7hMSK57hBOWfjeM
         hVHw==
X-Gm-Message-State: ACrzQf3Zv22b0KtSo7Gce0++rrL3V+Q9nk1ZpLeo7Q45UlhSECTPXMxw
        5lvGL+sVCATzC41G8OPIfF8=
X-Google-Smtp-Source: AMsMyM5mu4oFjWEYzRBfWSByoGXNtaj+5XV7Zdwzvg4BVzRXjR+OVS6eSiqEtzijbVJgKBwlBI8/2w==
X-Received: by 2002:a17:90a:5a02:b0:212:f91b:b2d0 with SMTP id b2-20020a17090a5a0200b00212f91bb2d0mr86081753pjd.244.1668104885607;
        Thu, 10 Nov 2022 10:28:05 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bd7b])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79ec7000000b0056b6acb58a0sm10482572pfq.102.2022.11.10.10.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:28:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Nov 2022 08:28:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y21Csx4q5ZpGZP64@slm.duckdns.org>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
 <Y208VBO9cZ5VL88m@kroah.com>
 <Y20+1otw2iwldKTl@slm.duckdns.org>
 <Y21BB4Mh4aQjf71c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21BB4Mh4aQjf71c@kroah.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:20:55PM +0100, Greg KH wrote:
> On Thu, Nov 10, 2022 at 08:11:34AM -1000, Tejun Heo wrote:
> > On Thu, Nov 10, 2022 at 07:00:52PM +0100, Greg KH wrote:
> > > Shouldn't:
> > > 	https://lore.kernel.org/r/Y0SwqBsZ9BMmZv6x@slm.duckdns.org fix this
> > > instead?
> > 
> > The difference is around whether the id based lookup can see hidden files or
> > not. But yeah, it makes more sense to hide it.
> 
> So your patch should not have been applied to my tree?  And I should
> take this one instead?

Oh, sorry. The patch you took is the better one and I was confused when I
was looking at this patch. No action necessary. It was just me being
confused.

Thanks.

-- 
tejun
