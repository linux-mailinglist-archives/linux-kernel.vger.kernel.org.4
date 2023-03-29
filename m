Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047776CED87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjC2PwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjC2Pvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:51:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C1469C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:51:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t10so65068478edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680105094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itOOgDvyewI5sV4EHXQFzc7/LHL9FDw9fBVihLrtw7s=;
        b=lhp6ZglBa9c0QLUWXgbmT5PrrN7rMjnajHS2zsUd2sf1mQeAsZUIH3NTp/8YOpwlJQ
         0QXkFRGzN1dbA471vSxbVskmLONJbzm1w1awWFUBshzCAU2n2oLEL2BQiOug2AS+Owr0
         4DfM+scYvNuzIMu2YXQbpuQDPzavUUuoMGCCfI7Scb+ja8W8popD9NN68nB1Z95RCRsp
         uZOFIGfuZLsX5zIsYooxMv01VZwiQmzDH3Xo2TMDto4MBfIJxrmqHtdUEA02WBUnNsBh
         mLbUBWrj5ldhUAKeXvMTep17N4LSNzvDcw0U+SLT8qvBr9djrXwKI/7UNRpPS9dW3lst
         yBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itOOgDvyewI5sV4EHXQFzc7/LHL9FDw9fBVihLrtw7s=;
        b=HrwFu63/FUZPaTN+ZbvXeTREGGYNBNwOWobPhLX3gkG5ieKaFWzNv0BYVIsXYXOe8a
         kD7Rgu2Q3aHT4cEAMBr5URmTtPPYblRrGcKsLHKpt/GifqdlRbmdyCw5OmojbSNrjqGH
         AIBaaUIHcE1OytZA6OO2X8yJ7Y6ObpAfhKLqUwghBu9r64Ixa5hMZe9HvYIN3j9BJTkM
         soniFGP2XNqsNErU54pPb7gKbX/2o776w1AlEEQidPwuAx7+up3zSE7esXnhZZyZTu7A
         /Em8XRQUJwYQH3i4KLLFf0unjpeuOsv/MyRvYy+RRg3ksVFglPs5VqrftKnmI2U7BcAp
         M72w==
X-Gm-Message-State: AAQBX9e5x4PpARskq9ozgPGbqK3uZ01Kw38ul6VFh/uKZCf1rHyA8/Lu
        y5GoLwgJNKMSmcrAqExUaQSqEg==
X-Google-Smtp-Source: AKy350aCqjt71Cph3G2qFotQdlf6yZfL5zqvdZ7ImpIWoTb5w5wXKkUJV3YiSMCEmpLPdVlx1EFFMA==
X-Received: by 2002:a17:907:8c0e:b0:930:bc07:3bf7 with SMTP id ta14-20020a1709078c0e00b00930bc073bf7mr22774104ejc.5.1680105094018;
        Wed, 29 Mar 2023 08:51:34 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906245b00b008d173604d72sm16924087ejb.174.2023.03.29.08.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:51:33 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:51:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v4 1/4] sched/psi: rearrange polling code in preparation
Message-ID: <ZCRehRsH5HhRCTic@cmpxchg.org>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
 <20230329153327.140215-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329153327.140215-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:33:24PM +0200, Domenico Cerasuolo wrote:
> Move a few functions up in the file to avoid forward declaration needed
> in the patch implementing unprivileged PSI triggers.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
