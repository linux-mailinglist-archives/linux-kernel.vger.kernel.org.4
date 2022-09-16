Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19575BB16B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIPREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIPREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:04:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F4DFE2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:04:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kr11so4776143ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lupBfLHVS7iObivxfHvMcw7u8808lL7OhJRfW9tv68U=;
        b=N5f/pMRQqpYVV1MpiJNdzuPpGKs8iP0HUnXbJWdLuX2YzcSB4u9I6dsQCYPesmAKfr
         irbw6/HKc2szlKfB7h5p8nV0geYjnEG9gdv9OCCjnntJAHwjf0yeZjEXdM1MyYqUaV3d
         BOjzWFd1AEJWXEEWMJ8hhMNSwil8VNPfSkzYy5Ecj2Hg0DebA/G8/QWc3w5cFcs+nQk8
         Dr6/bmfSInl6zMvJ0z28xLebKQvED4GRn+x/LQHQH0ON3MK/ajVS6ijA0s8x4b+MqPAh
         Q+CwrS4u7YHJalLGbQb4zmgcuZjHSBEs0Y3jPVeE0sXMGhzR58lpI/XwkYJ5UUQyCcRO
         SV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lupBfLHVS7iObivxfHvMcw7u8808lL7OhJRfW9tv68U=;
        b=zATSQVWTQ41j60nr6/b/No5n+yfAR7xINqHrM6qY+YPksuaZR8OV0nunu6a8sNjEz+
         7Maa7VkC8NQOZzjV5Rpmp4zpXRoHcJR/LkFcenxRw9vhnuho+PYq5HdwiqH172ugXqCu
         ye5c4tXj5Mi1BIChtTNxY6GhAU4FSz9xy3CTk2zbTQEkMDh45bL5iVmFesZzfgA97Tk9
         zmvgoGOOu5btC172Sz6rqnCyb1WM5QFThhbVYpHIn6nyVICJ4P5QOYQiSiovl20TQfV6
         fKxmB5bdSKpX1G8eoyTbyVxvK43zvu2VgS1s7h+hIPk7GMSKiQVr89ArD3aCosO97hq4
         PfTw==
X-Gm-Message-State: ACrzQf0Vx0iMRu6gL2q8B39mtqtYt9bjikSGRkhJY/pSV6o8VjIP4YPG
        hmMSobezmdskt3UIwLU2zDxZQ6TowPFxt0DU41k=
X-Google-Smtp-Source: AMsMyM608VMgpaAHn/4GIjDJKg3le3DXTcJzSrr02XPuu8Wj+5b032pcv9E33Fw+ux9JwktMhxM/jaWpuhyafH5V2gY=
X-Received: by 2002:a17:907:3e89:b0:779:4869:b799 with SMTP id
 hs9-20020a1709073e8900b007794869b799mr3943312ejc.91.1663347880720; Fri, 16
 Sep 2022 10:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164730.515767-1-e.shatokhin@yadro.com> <20220915164730.515767-3-e.shatokhin@yadro.com>
In-Reply-To: <20220915164730.515767-3-e.shatokhin@yadro.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Sep 2022 12:04:29 -0500
Message-ID: <CABb+yY2Yg1J4WZeB5MKmOONKNsS8468rJmeGkG1TS0Uw71bwYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: Error out early if the mbox driver has
 failed to submit the message
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, Ilya Kuznetsov <ilya@yadro.com>,
        linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:50 AM Evgenii Shatokhin
<e.shatokhin@yadro.com> wrote:
>
> mbox_send_message() places the pointer to the message to the queue
> (add_to_rbuf) then calls msg_submit(chan) to submit the first of the
> queued messaged to the mailbox. Some of mailbox drivers can return
> errors from their .send_data() callbacks, e.g., if the message is
> invalid or there is something wrong with the mailbox device.
>
The message can't be invalid because the client code is written for a
particular provider.

Though it is possible for the mailbox controller to break down for
some reason. In that case, the blocking api will keep retrying until
successful. But ideally the client, upon getting -ETIME, should free()
and request() the channel reset it (because controller drivers usually
don't contain the logic to automatically reset upon some error).

thanks.
