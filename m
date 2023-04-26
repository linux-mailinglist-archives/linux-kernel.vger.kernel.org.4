Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C056EFB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjDZUEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjDZUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:04:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE06137;
        Wed, 26 Apr 2023 13:04:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74db3642400so756954585a.2;
        Wed, 26 Apr 2023 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682539447; x=1685131447;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8EhR++F21MnuCKVAwLSKSp1SWlKKpmZyAIAO73KKxmA=;
        b=Kqm6EdSArtkpQX0jhcKd+a0rvd6gEmG20XOozEqv+uiBQRGvkknOgRRgaGsFZwrgc6
         CbqYOvbtvFC9+VPPJYfLTu80mB+r5bpDVIi/OqD1RcwphX9RypiB4rXSMwkcZEWgQaz9
         VtW58S+XTRozO/R3uRZi8YYeAfCERGXfBtnDBRa/xJ52ANbgt0Odjnntd9uR1lRsiU2d
         jE0mcRET0NowO/72BeXqmmZfTL4XrK+Ou7N/tX0K1qyH85Lezs42+BK6ZQa9gdSJDNbK
         w26orh9mPTLW3Y6N2+iHg7NWNYbW8KlHMf8TIA51knEwXIAz/cR+DFQ5HOLCrxHWB1ks
         N8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682539447; x=1685131447;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EhR++F21MnuCKVAwLSKSp1SWlKKpmZyAIAO73KKxmA=;
        b=HnYfYRWzofHg0lBeD4bg8of1C3ojlqG2+hoePojVyJvxVrnNSMAUK/PAZJU7jmiCQP
         gfuHsfi452OtlH3hGvLEs+pw7FCmJHmDCq2/yU+bUKE3hMgo8e6tYdzOmHHtvZ+kK6sw
         5LoTz16DyLTid+70/IgzLmq+/DWcjq4mUiXZH6FMfETbPDPA+oMM3tTqCuEnPUw1bIZP
         gasHFblsXpnzfFpP7wgWbcsNlcDTOnSqA+FIeRaeFxaZ7sscrAlVbFsT/fURL/tL8wvj
         kU5ktuCiwdoLRQz2/f16cNqE+BcvK1vQxqiqHqkl/KC4SzvpaBeoxO9FQC29dWdbK39X
         yZ4w==
X-Gm-Message-State: AAQBX9cgS/iLd8+TRt0cX+JEs27Sl4GfNpc9LjPKbck8358eR7lSmVRg
        CvSKpXBE+tFf4eDikcoDJzA5jn8renNj
X-Google-Smtp-Source: AKy350bA7umbCu3yk9zgjalOtBBPtc2Hb3mw952DIt2VTGJ9VtfAxJ+TqXeevwvS6rj5yJEKPR+9ng==
X-Received: by 2002:a05:622a:189b:b0:3ef:3f4b:31b8 with SMTP id v27-20020a05622a189b00b003ef3f4b31b8mr39999606qtc.7.1682539446669;
        Wed, 26 Apr 2023 13:04:06 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z26-20020ac87cba000000b003eb136bec50sm5534117qtv.66.2023.04.26.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 13:04:05 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:de9b:7730:1c53:557e])
        by serve.minyard.net (Postfix) with ESMTPSA id 3BE8F1800BA;
        Wed, 26 Apr 2023 20:04:04 +0000 (UTC)
Date:   Wed, 26 Apr 2023 15:04:03 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Craig Shelley <craig@microtron.org.uk>,
        Johan Hovold <johan@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Break doesn't work on a CP2105
Message-ID: <ZEmDs0ASdnEAnpsL@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a development board with a CP2105 on it, and I was trying to send
a break to it to do a sysrq.  And it wasn't working.

I have verified that the target driver works by setting a really slow
baud rate and sending something with a lot of zero bits.  It got breaks
just fine.

If I use TCSBRK, it seems to just send a short time with zeros, not
even a full character's worth.  It receives a valid character with the
top few bits set.  If I use TCSBRKP with a longer time, like 2.5
seconds, it waits the whole time, then at the very end it gets the
character as with the shorter break.

I can't find a programming manual for the chip, and I'm not sure what's
going on.

-corey
