Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D246DD5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDKIe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjDKIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:34:25 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7EE7E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:21 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-502739add9dso4345792a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/cdqt4/Qw/eHC3MyjspmUmPpLD46FYjasfrAvy9fKg=;
        b=0W2zCS5k5EIROj3lHM2+gRmwL2UE9a8ke1tg0wEEjlj1db/F5C4sek+h5BL+TwlCVX
         rgLHSseK2JyJJLwpbDBOlEFEOqrfvCg6vdYSp9BknNeqIvyj+u1Zz9Ia5bpRV3M4Xtfm
         V5ABqwY7MrfTnX0OPzr/T6utSGlpqZUMJExtfcPyFcn3mxFvWBAt0xdVg3t/rawfAukj
         9BN9K8VMT+E5gVzZx1SErCRC48Ue+uD4d3PM+d96rBjdoNDTlaNbt8W4dtWNG/Mw6yES
         KPt/dba534A8+t9MUT5D/o6K7VSCT2k12QSJEyZ5H3fypa6mvfEhfjJWiYXvzfk7GiL/
         7NZg==
X-Gm-Message-State: AAQBX9d9MaSEd9jSg1N/re2dfWDzaiPoOUQeAZiHzV4wJryxoJeynvNM
        yNy1BI7mbsVteq/OQY3o3p0=
X-Google-Smtp-Source: AKy350ZJBM8ORnqi1ilfRzs6MUnPknWG26QAhUkko50g8ibHRP704oUYNUN0P78jqatXg8kop+I57A==
X-Received: by 2002:a05:6402:38a:b0:504:a181:8185 with SMTP id o10-20020a056402038a00b00504a1818185mr6074753edv.32.1681202058884;
        Tue, 11 Apr 2023 01:34:18 -0700 (PDT)
Received: from localhost.localdomain (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.googlemail.com with ESMTPSA id v13-20020a50954d000000b004fc649481basm5683178eda.58.2023.04.11.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:34:17 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     JoseJavier.Rodriguez@duagon.com, Jorge.SanjuanGarcia@duagon.com,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/3] mcb patches for 6.4
Date:   Tue, 11 Apr 2023 10:33:26 +0200
Message-Id: <20230411083329.4506-1-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 

Here's this round's pile of patches for mcb I've collected.

It's fixing/quirking a issue with mcb FPGAs where the identification table
is smaller than expected and thus the subordinate drivers can't claim the
memory reagions they want.

Byte,
	Johannes

Rodríguez Barbarin, José Javier (3):
  mcb: Return actual parsed size when reading chameleon table
  mcb-pci: Reallocate memory region to avoid memory overlapping
  mcb-lpc: Reallocate memory region to avoid memory overlapping

 drivers/mcb/mcb-lpc.c   | 35 +++++++++++++++++++++++++++++++----
 drivers/mcb/mcb-parse.c | 15 ++++++++++-----
 drivers/mcb/mcb-pci.c   | 27 +++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.39.2

