Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14296B399C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCJJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCJJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:06:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DDB7DFB7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so17709540eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678438930;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=i6lN6CQSpZnV9KMLg5Ow3KwFs7VNf2F6kNgC3hAgxD0=;
        b=ReQWyhj/edoRQhoxlDUIMp3WD/1TEnoWv6Qu1ONEMkdSwMoMd7Bc7XxO5D2tsnWwgp
         cqU52EpR7DIfvo7iIDSCEzVjFtVwP4bveY5s8hBjz6anp6zr18T+0ULu1ZaTdNQfPNNd
         zKYdu1ZHQMHDRFakbjHTcexUezb8cCgfw/ixk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438930;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6lN6CQSpZnV9KMLg5Ow3KwFs7VNf2F6kNgC3hAgxD0=;
        b=MO2In0TvIYq5N636UuZObVCtH289ymx33hElmaOdlaAPnKwue9bBQ0A+MJIcQloqRF
         QcM27PJErbTvHPq/gdkBM5yYPf/zmi6V6YkbOocoFMzt1u2jad431F8kdFqAEBIBLvNK
         fsdJgKnwWjZ4dQKoQfxmX952NueGwbuX0ZU1062ozx+zqk9w8c8YF2+LJtU4pArrAz52
         Jqi/JDujyUFuS4x0F5yqCujmF0DgDoezyPVlT2IQapiMLOvalrgeOdyknHVH7JA48mxW
         /n92C/fuATMy0pL0ODGHqHY+Ewj3Sw2MQtD+qED0UDT/XmyFRaklsqfTFIoj6lVWxOna
         gTAQ==
X-Gm-Message-State: AO0yUKVDTEI5VPzMZ9SdZcpGm3+jEsHasFuuk0235rBdnwpC3c8C1ida
        6sRRpPsXBy8MA5W5z1dNJ1ScbA==
X-Google-Smtp-Source: AK7set/R0Q1SqiELB/B/Kw/GZy14et/8Skep/3xCMkeJzggqP+dWVLfAHbbMh17wSUgT2aG/PiekFg==
X-Received: by 2002:a17:906:27d7:b0:879:6abe:915e with SMTP id k23-20020a17090627d700b008796abe915emr25872855ejc.69.1678438930573;
        Fri, 10 Mar 2023 01:02:10 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef69:7ab6:87ac:99f])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b008b23b22b062sm692931ejq.114.2023.03.10.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:02:10 -0800 (PST)
Subject: [PATCH v7 0/6] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfxCmQC/4XNy2rDMBAF0F8JWldFGr276n+ULPSYxILYLpLjUI
 L/vdMui6lXw71wzzxZx1axs7fTkzVca6/zRMG9nFge4nRFXgtlBgJABBC8Ycep8OGx1BH7EsdPnh
 QCOAjgdWE0TLEjTy1OeaDpdL/dqBxqX+b29ftolXQ+/jVXyQXHkKVOYLwW+j0PbR7rfXyd25WdSV
 zhWAFSii/CSpuSlbCjqGNF/SgpXCKiu2hXdhR9rGhSoi8lS2V8hLCjmGPFkGKtsC5ki1L7HcUeK5
 aU7GIIEAJmZf4o27Z9A/3QuHYaAgAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Mar 2023 10:01:27 +0100
Message-Id: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ebsH4qiyS83w96/NDTZb8NlZnPHPn0skR/yJw1MN7IY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCvH7kTLaPbTlu6TXEpkTmkkKokvuYLlt+hkDylv6
 9zA5kyaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZArx+wAKCRDRN9E+zzrEiAODD/
 9LW6f/sem2H3MaMad8eJU0KejDIYjRthzOSS7fxuOctEg/hzhaSRiFaaYa+wpDsOTaA+y7u8Ui8x5+
 tp28bxvkguzobTneSBY3z+9ZE775p41pBR0x0cnET4dvadfoxHn6Yrbnd16dL2h1Hps4jn3BOR17xC
 Eoypr7j0Xd1/Hqc3Nj/DwEyi3RZY7ZlI1D+/05oSqLdKIxUrkI/Od2jXeJMt1XDie8vCBBApmLHQ1x
 LzdZIgSdSjJVG5zfbgPtgrvuSMJd8KffdOaTiKHYBJxDqLNKr/V+bkEctcUhNh0qFkht1aV2NQdNwu
 9qDy4jgO+OpFdi1p1B5+BGuPG+4Yp+58Ov/7MWU8A1uyob468ipsOr4f9GIDdn3+se5QIkv6FISMNg
 uiL1xtcr4XJT4K/LZ6rSTG4hJ0w8fvOiTymYbhnmigw88fvTW1LOoG9uFgYcwFrwekKYaWGLguFZPj
 d0cBb7zzGqVd4dfCN1oUHx9hNoqqvyBx5Z8Sx3m5nQpINEMve23LoA/1DTQagGztTSoO2W8GkqCP9a
 ucPmXEEzGgWGkjCidaPnrEmxLEEZB4PRUl7K3U76kAm81Gijs9HHcLt3v5XpzVNJdNZMMPfDHnwzMx
 AakalWF2lbtCPpL0YEBUuEBBIU84B0+ozXyElj+l603oI5thThb/MaDXm3uw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some fixes for fixing hw timestamp on some Logitech and SunplusIT
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

@HungNien, the logic for empty_ts has slightly changed since v4, would
be great if you could test it on your end.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v7: Thanks Sergey!
- Fix all negative modulus, including old bug
- Improve doc for 1/4 second accuracy.
- Link to v6: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org

Changes in v6 (Thanks Sergey!):
- Rebase on top of linus/master
- Add missing host_sof assignment, ups :(. Sorry about that!
- Improve comments for empty TS quirk
- Link to v5: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org

Changes in v5: Thanks Dan
- Check for !buf on empty TS packets.
- Link to v4: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org

Changes in v4 (Thanks Laurent!):
- Rebase on top of pinchart/next/uvc
- Use heuristic for UVC_QUIRK_IGNORE_EMPTY_TS
- Link to v3: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org

Changes in v3 (Thanks Laurent!):
- Rebase on top of pinchart/uvc/next
- Fix hw timestampt handling for slow FPS
  - Improve commit message
- Quirk for invalid dev_sof in Logi C922
  - Improve commit message
- Allow hw clock updates with buffers not full
  - Fix typo and improve messages
- Refactor clock circular buffer
  - Improve commit message
- Quirk for autosuspend in Logi C910
  - Improve commit message
  - Add comments around the quirk
- Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
  - Improve comments
- Allow quirking by entity guid
   - unsinged int
- Extend documentation of uvc_video_clock_decode()
   - uvcvideo on commit message
   - Improve comment
- Link to v2: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org

Changes in v2:
- Require 1/4 sec of data before using the hw timestamps
- Add Tested-by SunplusIT
- Link to v1: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Fix underflow addressing on hw timestamp
      media: uvcvideo: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 133 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 100 insertions(+), 44 deletions(-)
---
base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
