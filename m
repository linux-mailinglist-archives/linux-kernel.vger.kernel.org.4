Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8761E688320
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjBBPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23C61D58;
        Thu,  2 Feb 2023 07:54:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lu11so7256851ejb.3;
        Thu, 02 Feb 2023 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQbiZ+/fOllzP25ja5JcucvaVMNIjlZvALpLv7YmFcg=;
        b=LzEyVwAqONOq9cLXJv9KJpbvsYxGj5acXXp7/nwOCKbXPyfPVCV6VnCMT2v4TUpUQm
         c0zx0L8yr6HnDqDoQNDVHB80tfDg+8jX1VqdBoszF3ZU+uQM9A4cTTYavyxtO0dnWPX5
         +FUskfuFvq36aP8IQGzTZf7Z4G4hOixyRpryoX+/bu1PNDzmcu/LzW0UBPgL/JiDZ+vc
         d7j57Rgap52gy7wCJhG1JMpMtqn5+QgOjjZmPczT7Q7ANQ9AQ9HMWrLOEOvL9ZegVm/J
         bEU0HjBNhTDE6JohCDhPFeeF/ETE/kYuJKPusqQWuCYWlYfII3OFgGGceptf8EEBgXu0
         cthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQbiZ+/fOllzP25ja5JcucvaVMNIjlZvALpLv7YmFcg=;
        b=ZwM4vsXLe3mtsUyF5QiBt3CnVJT4kCyFrKbWjzp/zBsA5a3lViRPj2scCNce9E9MAI
         WVjFWXCEBv2zv8oChodjRFL3hudaVEYKVlKAMbQHy9fNQKYsYtTVYI22COGKeMHaOzQx
         hXu0YT9s+KmSDq7OWNMxL8kMupxxH2yzRtCZFRcsGugI5yO1jqtCSUMUnlnzR3bouFvV
         9e/RGLIPf5cpKRKXyrOjp9Vzr+8epximoMq+scTROHxgKqEAtsqftVxK8n1LOv6mehpy
         y0DzvBHwfzYGw/rWlUt6OXaeIOdzsgAaAEIqrHPjiFxI4JEUcGnQIaornxNlcVA0fbq1
         0mYA==
X-Gm-Message-State: AO0yUKVwwCp0MIffqQehPBKWhuF1CVInuTla4G1Hx/o7+jqwISxsVR/A
        9A6ZrPP4b/CTnsgTEnE/ei8=
X-Google-Smtp-Source: AK7set8HsgrycrAhBqjEgtBEKOzutls6dnKfkLL7IFEb8bB2y6asXQVt08wRL+Rpc9tHmxNZF7qxVQ==
X-Received: by 2002:a17:907:8e93:b0:88a:a09d:e650 with SMTP id tx19-20020a1709078e9300b0088aa09de650mr7661552ejc.58.1675353259067;
        Thu, 02 Feb 2023 07:54:19 -0800 (PST)
Received: from pc636 (host-78-79-169-126.mobileonline.telia.com. [78.79.169.126])
        by smtp.gmail.com with ESMTPSA id b18-20020a170906709200b0087bd2ebe474sm10319529ejk.208.2023.02.02.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:54:18 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 2 Feb 2023 16:54:15 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <Y9vcp2jADVzHl0AE@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201191211.GK2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201191211.GK2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:12:11AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 01, 2023 at 04:08:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> > it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> > 
> > 1.
> > The problem is that, recently we have run into a precedent when
> > a user intended to give a second argument to kfree_rcu() API but
> > forgot to do it in a code so a call became as a single argument
> > of kfree_rcu() API.
> > 
> > 2.
> > Such mistyping can lead to hidden bags where sleeping is forbidden.
> > 
> > 3.
> > _mightsleep() prefix gives much more information for which contexts
> > it can be used for.
> 
> Thank you!!!
> 
> I have queued these (aside from 10/13, which is being replaced by a
> patch from Julian Anastasov) for further testing and review.  And with
> the usual wordsmithing.
> 
Good. 10/13 will go with two arguments. So it is not needed. Just for
confirmation.

BTW, i see two complains from the robot due to 10/13 patch uses an old API
name.

>
> If testing goes well, I might try to get 1/13 into the next merge window,
> which would simplify things if maintainers want to take their patches
> separately.
> 
Thanks!

--
Uladzislau Rezki
