Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158F06E971D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjDTObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjDTOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:30:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82349F3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:30:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id xd13so6881942ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682001053; x=1684593053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqRgDrqqKcbVn3L4Sscjhct4ZfExtb0BxWV7D2nwwnE=;
        b=UfJjVGCkIWtlTSVg3OoeT0zJjt2S9pPJwJw0ZAsPsSUgVaksG9dtWAPC5HJEyOTfT/
         kbtHjRu8CtEJudyxGjb6kUaj423l7B5d3XbLplfUoEJtTlv+KDwyLZfwr4P2p5VAeKc5
         GqxY5qFSS4+mhChnheid5WkEWvEJsnfVaTkDZpE1KQYK5x3jmWTcaM8gLZ1wW9Toqffo
         4eT9OuId29nicDB2F+FG62MgPL+hBeYenqyqFlG4aZ8r9Zihq3LTllC9iRJ4HcQiWEyf
         vbXWhdgs7y2TaeYPig/470xGDa2XK+edWHC5BAMd+fNfXrBpoyQS42YOtYoeUUydLqBV
         hRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682001053; x=1684593053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqRgDrqqKcbVn3L4Sscjhct4ZfExtb0BxWV7D2nwwnE=;
        b=cbHOpeMcHhUQL2FOwvTDQWo7hacgCeN5bjiIV7Cl5HdIW82dIsh2xbsyi9IIkFYPd/
         Ju+vI6yvWkGwUYicbd0/NigQCo/0HrDsSjHZ17t2QKqRTxLru3FZ7sBDRrin5lfyvd3B
         E1ZsY81CSZtIxeMPXkN0zRzlzBgU/rApqyPb+T/U4K8eFfX4dtgI/hCD1pYCpwoGNpp0
         6ID/45az50YxK2rvjo87pZDUN+6BHgwR8mfFBViAUGSdwlYYDEiMGBcy2FQSJlNNjZmA
         acuYpRBExnKTGY2/5l3z6dN9uMrOXZ2uVu0a1JBmDTyGdSn0buS01bj2FzJIir8rivwQ
         R9fg==
X-Gm-Message-State: AAQBX9epIMKi3N2McN26FnIykb+/DYpa6hEOTqcf+bNfzJMcmwBHzwHF
        o9o0whLwGqypyGr47m2czMA=
X-Google-Smtp-Source: AKy350Y9gpAdlP98PrmhcnCOhjKGJcd2pzwyqpoeYQA41AJvR63U3/u1AWvoLuGT7sZU2p9e8yXX+Q==
X-Received: by 2002:a17:907:2c62:b0:94a:8e19:6aba with SMTP id ib2-20020a1709072c6200b0094a8e196abamr1643448ejc.21.1682001052993;
        Thu, 20 Apr 2023 07:30:52 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906054900b00923f05b2931sm787224eja.118.2023.04.20.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:30:52 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     broonie@kernel.org
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
        support.opensource@diasemi.com
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring constraints
Date:   Thu, 20 Apr 2023 16:30:45 +0200
Message-Id: <20230420143045.541253-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3eb854e2-8631-4f4e-aa00-d06236967f54@sirena.org.uk>
References: <3eb854e2-8631-4f4e-aa00-d06236967f54@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!

On Thu, 20 Apr 2023 at 14:17, Mark Brown <broonie@kernel.org> wrote:
> Are these constraints (ie, board specific limits) or are these more
> just properties of the regulator device?  It does feel useful to
> factor out this stuff, but it's not clear to me that these are things
> that should be configured on a per board basis.

These are actually properties of the regulator device. However, the
properties are only "active" if the voltage monitoring is wanted, which
is currently a per-board decision. Not sure if there might be reasons to
not activate it.


> These all sound like things where the regulator device is simply not
> going to support having monitoring enabled when doing the relevant
> actions no matter what situation we're in.  If that's the case we
> should just have the regulator driver set things up.

I think this would be feasible if the driver decides whether monitoring
is on or off (which might be a way to go). I think if the decision is
done per-board, it might simplify things to have the whole "should I
turn the monitor off now?" overhead not duplicated in every driver that
supports monitoring. What do you think?


> For the modes might it be clearer to mark a set of modes as not
> supporting monitoring?  I think that's the intended effect here.

Yes, that's true. I will change that.

Thanks and best regards,
Benjamin
