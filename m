Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55DE71A07C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjFAOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:40:38 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44386C0;
        Thu,  1 Jun 2023 07:40:37 -0700 (PDT)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.6])
        by mail.ispras.ru (Postfix) with ESMTPSA id B1CC140755C8;
        Thu,  1 Jun 2023 14:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B1CC140755C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685630433;
        bh=GxW32c51FDQOWKAHzqGDiyIkv54N+ouCAs5FBgOSLqE=;
        h=From:To:Cc:Subject:Date:From;
        b=tDQl3UfydlHbSkSB6A+CgkWBOh5Ferb+YBq/xZ0QBgQnn/ULZ5p8OaWb66gUciIz5
         WCkxwN9RZN1RPaizEIJFG1Ot9b3eqNGHf7X3GDrrTWdQ9iFnYqAxuz2aH8ftfRLXCS
         rHjtSGm9eQx0yGslaqoKe6TrqXS2X1oP/ARyr/1s=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, fuyufan <fuyufan@huawei.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 5.4/5.10 0/1] drm/atomic: Don't pollute crtc_state->mode_blob with error pointers
Date:   Thu,  1 Jun 2023 17:40:15 +0300
Message-Id: <20230601144016.475176-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

general protection fault in drm_mode_object_put() is hit on 5.4/5.10 if
drm_property_create_blob() fails for some reason and state->mode_blob is
assigned an error pointer which is not treated correctly in some places as
mentioned in patch description.

The following patch fixes the issue and can be cleanly applied to 5.4/5.10
stable branches.

Seems the patch could not be initially backported due to DRM_DEBUG_ATOMIC
-> drm_dbg_atomic() change.
