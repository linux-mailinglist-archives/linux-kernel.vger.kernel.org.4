Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0E6D785C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjDEJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbjDEJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:31:22 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C353A619C;
        Wed,  5 Apr 2023 02:30:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8B999EBD89;
        Wed,  5 Apr 2023 02:29:48 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s5oxiMETIkHI; Wed,  5 Apr 2023 02:29:47 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1680686987; bh=438mAnfkFufa/b6bnbJ4HftwsaJsmWOIH5P0gY1i8xk=;
        h=From:To:Cc:Subject:Date:From;
        b=U9MG0ypy7WpWfKxUH7HmkgFslBwpnQ46o2FkJg+5H6/7wwwg/UlzUWmnxownmWWRl
         gBTBdBG1LxyY8IIgdBWRKIV+3tDcHTRB9mJaV620gU4ReHggJxr8w0SNHQDEsRCjHg
         9T3Q99IygSCDDVt7fIXNvIKXHlYWZ/uj/zPuvcy6Y9QXnkbVs5l93VGNSUD62U6EN+
         piFCyyrS6KanWfidoami1+Skj3x8zEw+yKOHlJybsznmvqYVblq8VohUvLMO/2nqHx
         HPtO5O9v86n1b1dFTe5v7vN5bTbnUrQQTBlxZtKcmsYzVRH7dNKNjnoKAc8RrlgOmo
         0bzuFQzKDApuw==
To:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 0/2] media: hi846: support system suspend while streaming
Date:   Wed,  5 Apr 2023 11:29:02 +0200
Message-Id: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

the hi846 sensor driver was broken w.r.t. system suspend **while streaming**.
This is something that I did not test before initial submission.

These 2 small patches adjust the pm logic to support just that - stopping
streaming before suspending and resuming it again after system-resume.

I'm happy for any feedback,

thanks

                                martin


Martin Kepplinger (2):
  media: hi846: fix usage of pm_runtime_get_if_in_use()
  media: hi846: preserve the streaming state during system suspend

 drivers/media/i2c/hi846.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.30.2

