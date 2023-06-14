Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742E71881A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEaRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEaRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:09:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E51138;
        Wed, 31 May 2023 10:09:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bb15165ba06so883356276.2;
        Wed, 31 May 2023 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552939; x=1688144939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baXGCFPjiVm4hKY8HFDEh+Qcc3/O8IMzjxhb5gbhlkQ=;
        b=oA4NHcgA4YxpAozQXfbyydG/yObfcEwNiejOAERefN6bVUPjxcFAcVDcU1WIYJaEiG
         iFQ7TQuZRNdLnnBlDS3MSW8ERor+HbyC/AAsVyRYcLdUoRZ24lJe51zmjl2eaBSU1c9K
         IqpZ+j5NsvUyje8l/r5JzxIQfFfrnJ5/a6lAsF7GfpY2EMk7C9H5O+WxG5PblANeVypa
         g+abFU+7Dm919TKoa4g8EiKix7zv9qYCuAEnfxHpTWpMm9cmt1OQ9uMEMLDiaTSO3abj
         RsXLHmWB5Q4PhXwWomgPv+kZboCoD+3wUOdKywvGWnxK1hUMFpE9ArQiPTpJUYxtciTu
         05Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552939; x=1688144939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baXGCFPjiVm4hKY8HFDEh+Qcc3/O8IMzjxhb5gbhlkQ=;
        b=eMIBaqrf5DzOnFiF8eB9nqE35TDyu8r1K9KWG2KpppOW3GfNbYbXJoF85nNCazva+u
         dg8pYhOJG7tOcp00y5matzSn5zYbuR6ZvTasnd1dQQsIZ5YN+w204/3NzHngHQzGk3xV
         MFLU4snoLTGm+ujKlMiwtuzVPrFI7Lgdwspd/hsGNUbyL+oSDFs3/nMFqrrFzHu/6KoT
         ImBbUiwyGfbJdtZZGKPwRwRxPZ9Dg7LUr5EdckzjmT5B9kgGyJsDZBEMysBmkI6vamQZ
         hzzt9TmKlDPaDe5cyRVG4iMirik/IfnUsKPHBY7dhPVLUsFOxbSC/DM1x8Fprcyxiz/x
         1Xkg==
X-Gm-Message-State: AC+VfDwtc+pznFQPGxLmt1gLhHrGIr27r4X646bG6Rr53BMV+Rd2bIA6
        K7NSF4z7awlr9eJlSAusHCc=
X-Google-Smtp-Source: ACHHUZ4eE02QqroA4/J+lm4sDQfXkcnrj4WeDBxd4ESc36IKNEEkX1sBnBe/VErfNEtk2a2+qtLDiw==
X-Received: by 2002:a25:2556:0:b0:ba1:8234:242 with SMTP id l83-20020a252556000000b00ba182340242mr6599641ybl.58.1685552939134;
        Wed, 31 May 2023 10:08:59 -0700 (PDT)
Received: from localhost (128-092-077-170.biz.spectrum.com. [128.92.77.170])
        by smtp.gmail.com with ESMTPSA id 72-20020a25024b000000b00b9e2ef25f1asm4364850ybc.44.2023.05.31.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 10:08:58 -0700 (PDT)
Date:   Wed, 31 May 2023 10:08:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 0/8] sched/topology: add for_each_numa_cpu() macro
Message-ID: <ZHd/KgGN3tCe308V@yury-ThinkPad>
References: <20230430171809.124686-1-yury.norov@gmail.com>
 <ZHdrMiVSrPdM3xGn@yury-ThinkPad>
 <20230531100125.39d73e1d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531100125.39d73e1d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:01:25AM -0700, Jakub Kicinski wrote:
> On Wed, 31 May 2023 08:43:46 -0700 Yury Norov wrote:
> > On Sun, Apr 30, 2023 at 10:18:01AM -0700, Yury Norov wrote:
> > > for_each_cpu() is widely used in kernel, and it's beneficial to create
> > > a NUMA-aware version of the macro.
> > > 
> > > Recently added for_each_numa_hop_mask() works, but switching existing
> > > codebase to it is not an easy process.
> > > 
> > > This series adds for_each_numa_cpu(), which is designed to be similar to
> > > the for_each_cpu(). It allows to convert existing code to NUMA-aware as
> > > simple as adding a hop iterator variable and passing it inside new macro.
> > > for_each_numa_cpu() takes care of the rest.  
> > 
> > Hi Jakub,
> > 
> > Now that the series reviewed, can you consider taking it in sched
> > tree?
> 
> Do you mean someone else or did you mean the net-next tree?

Sorry, net-next.
