Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747DE6B1F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCIJGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCIJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:06:14 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97261508
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:05:21 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 82so1175209ybn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678352719;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdZHKPMPbWHjyZ6gJz1oMQnd9/OdrpXYtTBnXw1QWU0=;
        b=FKNnB6Y6SKqFJYBjpDgwitki91qaGZURzqZ4VGavDiBcqPjtWC//jTA2nZiWKC3EFD
         yustZRB3SV7BQtW0uqm0X7E8unn3zyUYrc3V79o6YQbDQ9sFRJZo+raj+JpJKTnSYUCf
         V6VwfIaBlHNwtJnUIPQACHf+X1Bhnqbk2n1k/HybGlrpbqe+df5Kw3x+3MFEDdrgifch
         cDkmZHCOWarSIPSga+KF7wFQPReQDWtlB+4juZd1I04ESBM2eIUIdUZccS45My5oJr/T
         1QuIrUutZiXhScxOQMuU5TXF85pSwHsZ2HEaweAm3iT+FWRnM5Z1kH4QM6bohFArYT5Y
         6d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352719;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdZHKPMPbWHjyZ6gJz1oMQnd9/OdrpXYtTBnXw1QWU0=;
        b=1RS5yBImaeydjAR/vYQ/CIlFPvKMhNUnnNnPh1iRQoAhdwJivpNCSNlEXH+IW8VosW
         sfTbt9Ps++LxsLN3WXRP24VFWjWaMfGdR+8rfg52gfpfHElJVdO0PAYIvoYMYTP6pZ4v
         gDGT2VE08GuBemfRqUpcQZ+8OV8eRXUKUoJVvtBOyoq9k0KJ78rgngym/9bTFHxPrGGa
         ZvbtbMCBfVq+bJTPgfxN+hmuNxcpihdX7vYde6PThONwx7Jn7s6txGLuJz+U4vdtdoOP
         F6/3RkJo4aqGOTgmv2dy52wGVtwN08J+k7+KacNoj6EpbQgop2B2Q2FDgI6xhfcVapPt
         y+ig==
X-Gm-Message-State: AO0yUKUqckyemFN/NVgOijix8k8MwuCzQCTD+lBN8oxBUzSv9Wwjv/sx
        +mwkwQdlQ/9i+SYoUjQv2Ym6khCU2UAqmwRX+rZStlDJ57E=
X-Google-Smtp-Source: AK7set/K3x9iStchYx4FrGsuXwg9Xj9sWiNMaLtllftN71PpQMlPXBOYSk/v+ItoTN758Xo0ORi1NF7GG5uS9LM6gBY=
X-Received: by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr12915983ybh.12.1678352719222; Thu, 09
 Mar 2023 01:05:19 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Thu, 9 Mar 2023 09:05:08 +0000
Message-ID: <CAC=wTOhzzjrynMZv9iKSFKY7ef+YVz=iE38iVxiVuOuXoWzY-w@mail.gmail.com>
Subject: Shutdown causes fsck on USB disks
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a (Ubuntu 22.04) system with a number of external USB disks.
When I do a 'shutdown now' with these disks mounted, on the next start
the disks have to be fsck-ed. So it seems that the disks are not
unmounted cleanly on shutdown; maybe the disks report 'completion'
before the data is really written, and the machine powers off before
allowing the unmount writes to complete.

Is this a kernel problem, or should I take it up with the Ubuntu maintainers ?

Chris Ward.
